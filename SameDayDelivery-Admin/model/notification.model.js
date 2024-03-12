const mongoose = require('mongoose');

const notificationModel = new mongoose.Schema({
    notification_id:{
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        default:new mongoose.Types.ObjectId,
    },
    order_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Order",
        required: true,
    },
    notification_type: {
        type: String,
        required: true,
        enum:["order","message","feedback"],
        default:"order",
    },
    notification_title: {
        type: String,
        required: true,
    },
    notification_description: {
        type: String,
        required: true,
    },
    notification_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
});

const Notification = mongoose.model("Notification", notificationModel);
module.exports = Notification;