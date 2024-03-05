const express= require("express");
const router = express.Router();

const riderController = require('../controller/rideController');

router.post('/add',riderController.addRideRecord);
router.get('/get/:_id',riderController.getUserRideRecord);
router.put('/delivered/:_id',riderController.onDelivered);
router.put('/rateReview/:_id',riderController.addRatingAndReview);

module.exports = router;