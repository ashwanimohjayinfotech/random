require("dotenv").config();
const express = require('express');
const connectDB = require('./config/db')
const userRoutes = require('./routes/userRoutes');
const authRoute = require('./routes/authRoute')
const cors = require("cors");




const app = express();
const PORT = 3000;

app.use(cors());
// Connect to MongoDB
connectDB();

// Middleware
app.use(express.json());

// Routes
app.use('/api/users', userRoutes);
app.use('/api/v1',authRoute);

// Start server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
