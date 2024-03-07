
const RideRecord = require("../model/rideRecord");
const userModel = require('../model/user.model');
const ObjectId = require("mongoose").Types.ObjectId;

exports.rideRecordFromSocket = async (body, socket) => {
    // const body = req.body;
    console.log("Ride Record from socket " + body);

    // if (!(body.userId && body.riderId && body.from && body.to && body.finalBid)) {
    //     return res.status(401).send('All fields required');
    // }
    try {
        const ride = await RideRecord.create({
            userId: body.userId ?? null,
            riderId: body.riderId ?? null,
            from: body.from ?? null,
            to: body.to ?? null,
            finalBid: body.finalBid ?? null,
            rideStatus: 'Pending',
        })
        socket.emit('success', body);

    } catch (e) {
        return socket.emit('error', e);
    }
}
exports.addRideRecord = async (req, res) => {
    const body = req.body;

    if (!(body.userId && body.riderId && body.from && body.to && body.finalBid)) {
        return res.status(401).send('All fields required');
    }
    try {
        const ride = await RideRecord.create({
            userId: body.userId,
            riderId: body.riderId,
            from: body.from,
            to: body.to,
            finalBid: body.finalBid,
            rideStatus: 'Pending',
        })
        return res.status(201).send('ride created');
    }
    catch (e) {
        return res.status(500).send(e);
    }
}


exports.getUserRideRecord = async (req, res) => {
    const user_id = req.params._id;
    const type = req.body.type;

    try {
        if (type === 'user') {
            const ride = await RideRecord.find({ userId: new ObjectId(user_id) })
            if (!ride) {
                return res.status(404).send('No rides found');
            }
            return res.status(200).send(ride);
        }
        if (type === 'rider') {
            const ride = await RideRecord.find({ riderId: new ObjectId(user_id) })
            if (!ride) {
                return res.status(404).send('No rides found');
            }
            return res.status(200).send(ride);
        }
    }
    catch (e) {
        return res.status(500).send(e);
    }
}

exports.onDelivered = async (req, res) => {
    const ride_id = req.params._id;

    try {
        const ride = await RideRecord.findByIdAndUpdate(ride_id, {
            rideStatus: "Shipped"
        });
        return res.status(200).send('Set to shipped');
    }
    catch (e) {
        return res.status(500).send(e);
    }

}

exports.addRatingAndReview = async (req, res) => {
    const ride_id = req.params._id;
    const { type, rating, review } = req.body;

    if (!(type && rating && review)) {
        return res.status(400).send('all fields required');
    }
    try {
        if (type === 'user') {
            const ride = await RideRecord.findByIdAndUpdate(ride_id, {
                riderRating: rating,
                riderReview: review
            });
            return res.status(200).send('Review and rating added for the rider')

        }
        if (type === 'rider') {
            const ride = await RideRecord.findByIdAndUpdate(ride_id, {
                userRating: rating,
                userReview: review
            });
            return res.status(200).send('Review and rating added for the user')
        }
    }
    catch (e) {
        return res.status(500).send(e);
    }
}