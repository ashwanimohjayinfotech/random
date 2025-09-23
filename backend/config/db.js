const mongoose = require("mongoose")

const connectDB = async () => {
  try {
    await mongoose.connect('mongodb+srv://ashwanimohjayinfotech_db_user:JZ6MHiDSYJO5NdIx@cluster0.i1onkkq.mongodb.net/', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB connected');
  } catch (error) {
    console.error('MongoDB connection failed:', error.message);
    process.exit(1);
  }
};

module.exports = connectDB;
