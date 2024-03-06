const express= require("express");
const router = express.Router();

const serviceController = require("../controller/service.controller");

router.post("/create", serviceController.createService);
router.get("/get", serviceController.getService);
router.put("/update", serviceController.updateService);
router.delete("/delete", serviceController.deleteService);

module.exports = router;