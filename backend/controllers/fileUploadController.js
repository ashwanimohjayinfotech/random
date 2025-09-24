const path = require("path");
const fileUploadModel = require("../models/fileUploadModel");
const { cloudinary } = require("../config/cloudinary");


exports.localFileUpload = async (req, res) => {
  try {
    // fetch file
    const file = req.files.file;
    console.log("File fetched:", file.name);

    // save in /uploads folder (in project root)
    const uploadPath = path.join(__dirname, "..", "uploads", Date.now() + "." + file.name.split(".").pop());
    console.log("Saving file to:", uploadPath);

    // move file
    file.mv(uploadPath, (err) => {
      if (err) {
        console.error("File save error:", err);
        return res.status(500).json({ success: false, message: "File save failed" });
      }
    });

    res.status(201).json({
      message: "File uploaded locally",
      success: true,
      path: uploadPath,
    });

  } catch (error) {
    console.error(error);
    res.status(401).json({
      message: "Unable to upload the file",
      success: false,
    });
  }
};


function isFileTypeSupported(type, supportedTypes) {
  return supportedTypes.includes(type);
}

async function uploadFileToCloudinary(file, folder) {
  return await cloudinary.uploader.upload(file.tempFilePath, { folder });
}

exports.imageUpload = async (req, res) => {
  try {
    const { name, email, tags } = req.body;
    console.log("Body:", name, email, tags);

    const file = req.files.imageFile;
    console.log("File received:", file.name);

    // validation
    const supportedTypes = ["jpg", "jpeg", "png"];
    const fileType = file.name.split(".").pop().toLowerCase();

    if (!isFileTypeSupported(fileType, supportedTypes)) {
      return res.status(400).json({
        success: false,
        message: "File format not supported",
      });
    }

    // upload to cloudinary
    const response = await uploadFileToCloudinary(file, "images");
    console.log("Cloudinary response:", response);

    res.status(201).json({
      message: "Image uploaded successfully",
      success: true,
      url: response.secure_url, 
    });

  } catch (error) {
    console.error(error);
    res.status(401).json({
      message: "Unable to upload the image",
      success: false,
    });
  }
};
