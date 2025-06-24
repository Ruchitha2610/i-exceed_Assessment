const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3500;

app.use(cors());
app.use(bodyParser.json());

// In-memory data (you can later use MongoDB or any database)
let products = [
  { id: 1, title: 'Sample Product', description: 'A great product', price: 9.99 }
];

// GET all products
app.get('/api/products', (req, res) => {
  res.json(products);
});


app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

