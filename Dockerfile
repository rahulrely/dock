# -----------------------------------------
# Stage 1: Dependency Resolver
# -----------------------------------------
FROM node:22-alpine AS deps

WORKDIR /app

COPY package*.json ./
# Install only production dependencies
RUN npm ci --omit=dev

# -----------------------------------------
# Stage 2: Final Production Runtime
# -----------------------------------------
FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# 1. Copy production node_modules from deps stage
COPY --from=deps /app/node_modules ./node_modules
COPY package*.json ./

# 2. Copy application source code
COPY . .

# 3. Security: Run container as non-root built-in node user
USER node

EXPOSE 3000

# Run node directly (faster startup and receives POSIX signals cleanly)
CMD ["node", "index.js"]