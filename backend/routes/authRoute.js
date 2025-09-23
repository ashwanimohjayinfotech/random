const express = require("express");
const { signup, login } = require("../controllers/authControllers");
 const router = express.Router()


const { isUser, verifyToken, isAdmin } = require("../middleware/authMiddleware");

router.post("/signup",signup)
router.post("/login",login)

router.post("/user", verifyToken, isUser, (req,res) => {
    res.json({
        success: true,
        message: "This is protected route for users "
    })
})

router.post("/admin", verifyToken, isAdmin, (req,res) => {
    res.json({
        success: true,
        message: "this is protected route for the admin"
    })
})

module.exports = router;