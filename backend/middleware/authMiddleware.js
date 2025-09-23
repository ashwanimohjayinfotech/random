const express = require("express")
const JWT = require("jsonwebtoken")


exports.verifyToken = (req, res, next) => {
  try {
    const authHeader = req.headers["authorization"];

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).json({
        success: false,
        message: "No token provided",
      });
    }

    const token = authHeader.split(" ")[1];

    // verify token
    const decoded = JWT.verify(token, process.env.JWT_SECRET);

    req.user = decoded; 

    next();
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: "Invalid or expired token",
    });
  }
};

exports.isUser = (req,res,next) => {
    try {
        if(req.user.role != 0){
            return res.status(403).json({
                success: false,
                message: "access denied"

            })
        }
        next()
    } catch (error) {
        return res.status(403).json({
            success: false,
            message: "error verifying user "
        })
        
    }
}
exports.isAdmin = (req,res,next) => {
   try {
    if(req.user.role != 1){
        return res.status(403).json({
            success: false,
            message: "access denied"
        })
    }
    next()
   } catch (error) {
    res.status(403).json({
        success: false,
        message: "error verifying user "
    })
   }
}
