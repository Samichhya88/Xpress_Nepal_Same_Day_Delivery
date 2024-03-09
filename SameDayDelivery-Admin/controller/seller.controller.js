const sellerModel = require("../model/seller.model");

exports.createSeller = async (req, res) => {
  const {
    seller_name,
    seller_email,
    seller_password,
    seller_phone,
    seller_address,
  } = req.body;

  try {
    const seller = new sellerModel({
      seller_name,
      seller_email,
      seller_password,
      seller_phone,
      seller_address,
    });
    await seller.save();

    return res.send({
      status: 200,
      message: "Seller created successfully",
      data: seller,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};

exports.getSeller = async (req, res) => {
  try {
    const sellers = await sellerModel.find();

    return res.send({
      status: 200,
      message: "Sellers fetched successfully",
      data: sellers,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};

exports.updateSeller = async (req, res) => {
  const sellerId = req.params.id;
  const updates = req.body;

  try {
    const seller = await sellerModel.findByIdAndUpdate(sellerId, updates, {
      new: true,
    });

    if (!seller) {
      return res.status(404).send("Seller not found");
    }

    return res.send({
      status: 200,
      message: "Seller updated successfully",
      data: seller,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};

exports.deleteSeller = async (req, res) => {
  const sellerId = req.params.id;

  try {
    const seller = await sellerModel.findByIdAndDelete(sellerId);

    if (!seller) {
      return res.status(404).send("Seller not found");
    }

    return res.send({
      status: 200,
      message: "Seller deleted successfully",
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};
