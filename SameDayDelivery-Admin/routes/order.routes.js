const express = require("express");
const router = express.Router();

const orderController = require("../controller/order.controller");

router.post("/create", orderController.createOrder);
router.get("/get", orderController.getOrder);
router.get("/getUserOrder", orderController.getUserOrder);
router.put("/update", orderController.updateOrder);
router.delete("/delete", orderController.deleteOrder);

module.exports = router;