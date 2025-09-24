require("dotenv").config();
const express = require('express');
const connectDB = require('./config/db')
const userRoutes = require('./routes/userRoutes');
const authRoute = require('./routes/authRoute')
const cors = require("cors");
const cloudinary = require("./config/cloudinary")
const fileUploadRoute = require("./routes/fileUploadRoute")
const { cloudinaryConnect } = require("./config/cloudinary");
const fileUpload = require("express-fileupload")



const app = express();
const PORT = 3000;

app.use(cors());
// Connect to MongoDB
connectDB();

// Middleware
app.use(express.json());
app.use(fileUpload({
  useTempFiles: true,
  tempFileDir: "/tmp/",
}));

//connecting cloud
cloudinary.cloudinaryConnect();

// Routes
app.use('/api/users', userRoutes);
app.use('/api/v1',authRoute);
app.use('/api/v1/fileUpload',fileUploadRoute)

// Start server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
