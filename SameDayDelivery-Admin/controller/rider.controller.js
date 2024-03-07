const riderModel = require("../model/rider.model");

exports.createRider = async (req, res) => {
  const {
    rider_name,
    rider_email,
    rider_password,
    rider_phone,
    rider_address,
  } = req.body;

  try {
    const rider = new riderModel({
      rider_name,
      rider_email,
      rider_password,
      rider_phone,
      rider_address,
    });
    await rider.save();

    return res.send({
      status: 200,
      message: "Rider created successfully",
      data: rider,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};

exports.getRider = async (req, res) => {
  try {
    const riders = await riderModel.find();

    return res.send({
      status: 200,
      message: "Riders fetched successfully",
      data: riders,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};

exports.updateRider = async (req, res) => {
  const riderId = req.params.id;
  const updates = req.body;

  try {
    const rider = await riderModel.findByIdAndUpdate(riderId, updates, {
      new: true,
    });

    if (!rider) {
      return res.status(404).send("Rider not found");
    }

    return res.send({
      status: 200,
      message: "Rider updated successfully",
      data: rider,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};

exports.deleteRider = async (req, res) => {
  const riderId = req.params.id;

  try {
    const rider = await riderModel.findByIdAndDelete(riderId);

    if (!rider) {
      return res.status(404).send("Rider not found");
    }

    return res.send({
      status: 200,
      message: "Rider deleted successfully",
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};
