const mongoose = require('mongoose');

const productModel = new mongoose.Schema({
    product_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        default:new mongoose.Types.ObjectId,
    },
    seller_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Seller",
        required: true,
    },
    product_name: {
        type: String,
        required: true,
        index: true,
    },
    product_price: {
        type: Number,
        required: true,
    },
    product_image: {
        type: String,
        required: true,
    },
    product_description: {
        type: String,
        required: true,
    },
    product_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
    product_category:{
        type:String,
        required:true,
        enum:["food","clothing","electronics","furniture","medicine","other"],
        default:"other",
    }
});

module.exports = mongoose.model("Product", productModel);