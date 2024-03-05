const express= require("express");
const router = express.Router();

const riderController = require("../controller/rider.controller");

router.post("/register", riderController.createRider);
router.post("/login", riderController.getRider);
router.put("/update", riderController.updateRider);
router.delete("/delete", riderController.deleteRider);

module.exports = router;