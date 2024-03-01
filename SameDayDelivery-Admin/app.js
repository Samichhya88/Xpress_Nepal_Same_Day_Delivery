const express = require("express");
const app = express();
const path = require("path");
const bodyParser = require("body-parser");

app.use(bodyParser.json()); // Parse JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));
const cookieParser = require("cookie-parser");
const cors = require("cors");
app.use(
  cors({
    origin: ["http://localhost:5173", "http://127.0.0.1:5500", "http://192.168.18.47:3000"],
    credentials: true,
  })
);
//routes
const orderRoutes = require("./routes/order.routes");
const userRoutes = require("./routes/user.routes");
const productRoutes = require("./routes/product.routes");
const rideRoutes = require('./routes/ride.routes');

app.get("/", (req, res) => {
  res.send("Server Working Correctly...");
});

app.use("/order", orderRoutes);
app.use("/user", userRoutes);
app.use("/product", productRoutes);
app.use('/ride', rideRoutes);

module.exports = app;
