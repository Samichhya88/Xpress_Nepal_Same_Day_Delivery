const mongoose = require("mongoose");
const { Schema } = mongoose;

const userSchema = new Schema({
  fullName: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    trim: true,
  },
  phoneNumber: {
    type: [String],
    trim: true,
  },

  role: {
    type: String,
    required: true,
    enum: ["rider", "user", "shopkeeper"],
    default: "user",
  },

  address: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    default: Date.now,
  },
});

const userModel = mongoose.model("users", userSchema);
module.exports = userModel;
