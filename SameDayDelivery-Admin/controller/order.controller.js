const Order = require("../model/order.model");

exports.createOrder = async (req, res) => {
  try {
    const {
      user_id,
      service_id,
      rider_id,
      order_status,
      order_amount,
      order_address,
      order_description,
      order_starting_point,
      order_ending_point,
      delivery_charge,
    } = req.body;

    console.log(req.body);

    const order = await Order.create({
      user_id,
      service_id,
      rider_id,
      order_status,
      order_amount,
      order_address,
      order_description,
      order_starting_point,
      order_ending_point,
      delivery_charge,
    });

    await order.save();

    return res.status(201).json(order);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
};
exports.getUserOrder = async (req, res) => {
  try {
    const id = req.query.id;
    const orders = await Order.find({
      user_id: id,
    });

    if (!orders) {
      return res.status(404).send("No orders found");
    }

    res.status(200).json(orders);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
}


exports.getOrder = async (req, res) => {
  try {
    const orders = await Order.find();
    res.status(200).json(orders);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
};

exports.updateOrder = async (req, res) => {
  try {
    const orderId = req.params.id;
    const updates = req.body;

    const order = await Order.findByIdAndUpdate(orderId, updates, {
      new: true,
    });

    if (!order) {
      return res.status(404).send("Order not found");
    }

    res.status(200).json(order);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
};

exports.deleteOrder = async (req, res) => {
  try {
    const orderId = req.params.id;

    const order = await Order.findByIdAndDelete(orderId);

    if (!order) {
      return res.status(404).send("Order not found");
    }

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
};
