import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'satellite.html'));
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
  console.log('Open your browser and navigate to http://localhost:3000 to view the application.');
});