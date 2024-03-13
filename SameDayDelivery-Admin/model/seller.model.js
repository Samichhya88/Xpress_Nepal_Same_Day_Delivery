const mongoose = require("mongoose");

const sellerModel = new mongoose.Schema({
    seller_name: {
        type: String,
        required: true,
    },
    seller_email: {
        type: String,
        required: true,
    },
    seller_password: {
        type: String,
        required: true,
    },
    seller_phone: {
        type: String,
        required: true,
    },
    seller_address: {
        type: String,
        required: true,
    },
    seller_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
});

const Seller = mongoose.model("Seller", sellerModel);
module.exports = Seller;