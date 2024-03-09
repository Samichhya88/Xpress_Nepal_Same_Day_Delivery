const userModel = require("../model/user.model");
const md5 = require("md5");
const { createJwt } = require("../middlewares/jwtAuthMiddleware");
const { mongoose } = require("mongoose");
const { ObjectId } = require("mongodb");

exports.register = async (req, res) => {
  const body = req.body;
  console.log("Received data:", req.body);

  if (!(body.email && body.password && body.fullName)) {
    res.status(400).send("All input required");
  }
  const email = body.email;
  const oldEmail = await userModel.findOne({ email });
  if (oldEmail) {
    return res.status(409).send("Email already used");
  }
  const md5Password = md5(body.password);
  const user = await userModel.create({
    email: body.email,
    password: md5Password,
    fullName: body.fullName,
    phoneNumber: body.phoneNumber ?? "",
    address: body.address,
    role: body.role ?? "user",
  });
  return res.status(201).send(user);
};

exports.signIn = async (req, res) => {
  const { email, password } = req.body;
  console.log("Received data:", req.body);

  if (!(email && password)) {
    console.log("All input is required");
    return res.status(400).send({
      message: "All input is required",
    });
  }

  const user = await userModel.findOne({ email });
  if (!user) {
    console.log("User not found");
    return res.status(404).send({
      message: "User not found",
    });
  }

  const password_check = md5(password) === user.password;

  if (!password_check) {
    console.log("Invalid credentials");
    return res.status(400).send({
      success: false,
      message: "Invalid credentials",
    });
  }

  const token = createJwt(user);

  return res
    .status(201)
    .cookie("token", token, {
      expires: new Date(Date.now() + 25892000000),
      httpOnly: false,
    })
    .send({
      success: true,
      message: "Logged in successfully",
      user: user,
    });
};
exports.signOut = async (req, res) => {
  return res.status(201).clearCookie("token").send({
    message: "Logged out successfully",
  });
};

exports.getUser = async (req, res) => {
  var id = req.params["id"];
  id = id.trim();
  console.log("Received data:", req.params);


  const user = await userModel.findById(id);
  if (!user) {
    console.log("User not found");
    return res.status(404).send({
      message: "User not found",
    });
  }
console.log(user);
  return res.status(200).send(user);
};

exports.updateUser = async (req, res) => {};
exports.deleteUser = async (req, res) => {};

