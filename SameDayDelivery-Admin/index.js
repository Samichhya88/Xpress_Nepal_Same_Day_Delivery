const Database = require("./config/database");
const app = require("./app");
const http = require("node:http");
const server = http.createServer(app);
const initializeSocketIO = require("./services/socketService");
const PORT = process.env.PORT || 3000;

//cors

initializeSocketIO(server);

(async () => {
  try {
    await Database.connect();
    server.listen(PORT, () => {
      console.log("Server is up on port " + PORT);
      console.log("http://localhost:" + PORT);
    });
  } catch (error) {
    console.error("Error connecting to the database:", error);
  }
})();
