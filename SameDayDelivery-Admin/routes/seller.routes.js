const express = require("express");
const router = express.Router();

const sellerController = require("../controller/seller.controller");

router.post("/create", sellerController.createSeller);
router.get("/get", sellerController.getSeller);
router.put("/update", sellerController.updateSeller);
router.delete("/delete", sellerController.deleteSeller);

module.exports = router;
