const express= require("express");
const router = express.Router();

const productController = require("../controller/product.controller");

router.post("/create", productController.createProduct);
router.get("/", productController.getProduct);
router.put("/update", productController.updateProduct);
router.delete("/delete/:id", productController.deleteProduct);

module.exports = router;