const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

// Initialize express app
const app = express();
const port = process.env.PORT || 3000;

// Apply middlewares
app.use(cors());
app.use(helmet());
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', timestamp: new Date() });
});

// Sample API endpoint
app.get('/api', (req, res) => {
  res.json({ message: 'Hello from the API!' });
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

module.exports = app; // Export for testing
