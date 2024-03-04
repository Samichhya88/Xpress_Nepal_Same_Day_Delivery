const router = require("express").Router();

const {
  postNotification,
  getAllNotification,
  getUserNotification,
} = require("../controller/notification.controller");

router.post("/add/:_id", postNotification);
router.get("/getAll", getAllNotification);
router.get("/get/:_id", getUserNotification);

module.exports = router;
