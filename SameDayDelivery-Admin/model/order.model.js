const mongoose = require("mongoose");

const orderModel = new mongoose.Schema({
    order_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        default:new mongoose.Types.ObjectId,
    },
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref:"User",
        required: true,
    },
    service_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref:"Service",
        required: true,
    },
    rider_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref:"Rider",
        required: true,
    },
    order_status: {
        type: String,
        required: true,
        default: "pending",
        enum:["pending","accepted","rejected","completed"],
    },
    order_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
    order_amount: {
        type: Number,
        required: true,
    },
    order_address: {
        type: String,
        required: true,
    },
    order_description: {
        type: String,
        required: true,
    },
    order_starting_point: {
        type: String,
        required: true,
    },
    order_ending_point: {
        type: String,
        required: true,
    },
    order_initiate_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
    order_completion_date: {
        type: Date,
        default: new Date(new Date().setDate(new Date().getDate() + 7)), //a week after todays date,
    },
    delivery_charge: {
        type: Number,
        required: true,
    },
});

const Order = mongoose.model("Order", orderModel);
module.exports = Order;