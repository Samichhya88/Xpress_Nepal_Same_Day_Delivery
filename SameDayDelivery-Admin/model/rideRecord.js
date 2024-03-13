const mongoose = require('mongoose');

const rideRecordModel = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "users",
    },
    riderId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "users",
    },
    from: {
        type: String,
        required: true,
    },
    to: {
        type: String,
        required: true,
    },
    finalBid: {
        type: String,
        required: true,
    },
    rideDate: {
        type: Date,

        default: Date.now,
    },
    rideStatus: {
        type: String,
        enum: ['Pending', 'Shipped'],
        default: 'Pending',
        required: true,
    },
    riderRating: {
        type: Number,

    },
    userRating: {
        type: Number
    },
    riderReview: {
        type: String,
    },
    userReview: {
        type: String
    }

});

const RideRecord = mongoose.model("RideRecord", rideRecordModel);
module.exports = RideRecord;