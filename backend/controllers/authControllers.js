const bcrypt = require("bcrypt");
const JWT = require("jsonwebtoken");
const authModel = require("../models/authModel");

// signup
// signup
exports.signup = async (req, res) => {
  try {
    const { name, email, password, role } = req.body;

    // check if user exists
    const existingUser = await authModel.findOne({ email });
    if (existingUser) {
      return res.status(409).json({
        success: false,
        message: "User already exists",
      });
    }

    // hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // create user
    const user = await authModel.create({
      name,
      email,
      password: hashedPassword,
      role,
    });

    // ✅ No token here
    return res.status(201).json({
      success: true,
      message: "User created successfully",
      user: {
        name: user.name,
        email: user.email,
        role: user.role,
      },
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Unable to create user",
      error: error.message,
    });
  }
};


// login
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // check if user exists
    const user = await authModel.findOne({ email });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found",
      });
    }

    // check password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: "Invalid login credentials",
      });
    }

    // create JWT
    const payload = { email: user.email, id: user._id, role: user.role };
    const token = JWT.sign(payload, process.env.JWT_SECRET, { expiresIn: "2d" });

    return res.status(200).json({
      success: true,
      message: "Login successful",
      token,
      user: {
        name: user.name,
        email: user.email,
        role: user.role,
      },
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Unable to login",
      error: error.message,
    });
  }
};
