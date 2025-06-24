require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());


const mongoURI = process.env.MONGO_URI;
mongoose.connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => console.log("✅ MongoDB Connected"))
  .catch((err) => console.error("❌ MongoDB Connection Failed", err));

// Animal Schema
const animalSchema = new mongoose.Schema({
    name: String,
    species: String,
    age: Number,
});

const Animal = mongoose.model('Animal', animalSchema);

// Routes
    app.post('/animals', async (req, res) => {
    const { name, species, age } = req.body;
    try {
        const newAnimal = new Animal({ name, species, age });
        await newAnimal.save();
        res.status(201).json(newAnimal);
    } catch (error) {
        res.status(500).json({ error: 'Failed to add animal' });
    }
});

app.get('/animals', async (req, res) => {
    try {
        const animals = await Animal.find();
        res.json(animals);
    } catch (error) {
        res.status(500).json({ error: 'Failed to fetch animals' });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Server running on http://localhost:${PORT}`));
