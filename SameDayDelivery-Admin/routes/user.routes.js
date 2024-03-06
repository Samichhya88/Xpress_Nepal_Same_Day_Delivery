const express = require("express");
const router = express.Router();

const userController = require("../controller/user.controller");

router.post("/register", userController.register);
router.post("/login", userController.signIn);
router.put("/update", userController.updateUser);
router.delete("/delete", userController.deleteUser);
router.post("/logout", userController.signOut);
router.get("/:id", userController.getUser);

module.exports = router;
