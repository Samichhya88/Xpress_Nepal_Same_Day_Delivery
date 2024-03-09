const productModel = require("../model/product.model");

exports.createProduct = async (req, res) => {
  const {
    seller_id,
    product_name,
    product_price,
    product_image,
    product_description,
    product_date,
  } = req.body;
  try {
    const product = new productModel({
      seller_id,
      product_name,
      product_price,
      product_image,
      product_description,
      product_date,
    });
    await product.save();
    return res.send({
      status: 200,
      message: "Product created successfully",
      data: product,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};
exports.getProduct = async (req, res) => {
  const limit = parseInt(req.query.limit) || 10;
  const page = parseInt(req.query.page) || 1;
  const skip = (page - 1) * limit;

  const price = req.query.price;
  const seller = req.query.seller_id;
  const name = req.query.product_name;
  const category = req.query.category;
  let filter = {};
  if (price) {
    filter.product_price = { $lte: price };
  }
  if (seller) {
    filter.seller_id = seller;
  }
  if (name) {
    filter.product_name = name;
  }
  if (category) {
    filter.product_category = category;
  }
  try {
    const product = await productModel.find(filter).limit(limit).skip(skip);
    console.log(product);
    return res.send({
      status: 200,
      message: "Product fetched successfully",
      data: product,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};
exports.updateProduct = async (req, res) => {
  const productId = req.params.id;
  const updates = req.body;

  try {
    const product = await productModel.findByIdAndUpdate(productId, updates, {
      new: true,
    });

    if (!product) {
      return res.status(404).send("Product not found");
    }

    return res.send({
      status: 200,
      message: "Product updated successfully",
      data: product,
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};

exports.deleteProduct = async (req, res) => {
  const productId = req.params.id;

  try {
    const product = await productModel.findByIdAndDelete(productId);

    if (!product) {
      return res.status(404).send("Product not found");
    }

    return res.send({
      status: 200,
      message: "Product deleted successfully",
    });
  } catch (error) {
    return res.send({
      status: 400,
      message: error.message,
    });
  }
};
