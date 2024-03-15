const mongoose = require("mongoose");

class Database {
  static async connect() {
    //Insert MONGODB_URI here
    const MONGODB_URI = "mongodb+srv://karkisamichhya88:TJkQSCjgSR6dUPp5@fyp.4hb7hmh.mongodb.net/?retryWrites=true&w=majority"
    try {
      mongoose.connect(MONGODB_URI, {
        useNewUrlParser: true,
       
      });
      console.log("Database connected successfully");
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
}

module.exports = Database;