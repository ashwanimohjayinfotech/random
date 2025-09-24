const express = require("express");
const { localFileUpload, imageUpload } = require("../controllers/fileUploadController");

const router = express.Router();

router.post("/localFileUpload",localFileUpload);
router.post("/Upload",imageUpload)

module.exports = router;