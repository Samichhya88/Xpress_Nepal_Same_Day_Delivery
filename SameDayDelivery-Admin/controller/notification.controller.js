const Notification = require("../model/notification.model");
const ObjectId = require("mongoose").Types.ObjectId;
const userModel = require("../model/user.model");

async function postNotification(req, res) {
  const receiverUserId = req.params._id;
  const body = req.body;
  if (!body.message) {
    return res.status(400).send("Notification message required");
  }

  try {
    const user = await userModel.findOne({ _id: new ObjectId(receiverUserId) });
    if (!user) {
      return res.status(404).send("User not Found");
    }
  } catch (e) {
    return res.status(400).send("Invalid user");
  }

  try {
    const notification = await Notification.create({
      receiverUser: receiverUserId,
      message: body.message,
      isRead: false,
      notificationType: body.notificationType,
      metaData: body.metaData,
    });

    return res.status(201).send(notification);
  } catch (e) {
    return res.status(500).send(`Error adding notification ${e}`);
  }
}

async function getAllNotification(req, res) {
  const allNotification = await Notification.find({});
  if (!allNotification) {
    return res.status(404).send("No notification found");
  }
  return res.status(201).send(allNotification);
}

async function getUserNotification(req, res) {
  const userId = req.params._id;
  try {
    const user = await userModel.findOne({ _id: new ObjectId(userId) });
    if (!user) {
      return res.status(404).send("User not Found");
    }
  } catch (e) {
    return res.status(400).send("Invalid user");
  }
  try {
    const notification = await Notification.find({ receiverUser: userId });
    if (!notification) {
      return res.status(404).send("NO notification found");
    }
    return res.status(201).send(notification);
  } catch (e) {
    return res.status(404).send(`Error finding notification ${e.message}`);
  }
}

module.exports = {
  postNotification,
  getAllNotification,
  getUserNotification,
};
