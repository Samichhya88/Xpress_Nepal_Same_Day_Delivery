const socketIO = require('socket.io');
const rideController = require('../controller/rideController')
function initializeSocketIO(server) {
    const io = socketIO(server, {
        cors: {
            origin: ["http://localhost:5173", "http://127.0.0.1:5500", "http://192.168.18.47:3000"],
            credentials: true,
        },
        connectionStateRecovery: {}
    });
    var riderId = {};
    var requestUserId = {};
    io.on('connection', (socket) => {

        console.log(`Client connected ${socket.id}`);

        //on riders connected,
        //their mongodb _id is sent from frontend
        //storing _id:socket.io in a object
        socket.on('riderConnected', (rider) => {
            console.log(rider);
            // riderId[id.riderId] = socket.rider;
            // console.log(`rider connected ${id.riderId}`)
            riderId[rider._id] = socket.id;
            console.log(riderId);
        });

        socket.on('requestRide', (request) => {
            console.log("Requset for ride")
            console.log(request);
            //ToDo:
            //store requesting user socket.id in a var
            requestUserId[request.userId] = socket.id;
            //for each rider in riderId object 
            //put their socket id to emit request to drivers only
            Object.keys(riderId).forEach(key => {
                io.to(riderId[key]).emit('request', request);
            })

        })

        //bid should consist riders mongo _id and Rs amount.
        //bid also should consist of id of requesting user.
        socket.on('bid', (bid) => {
            //from _id we can get rider info from mongodb
            //and send rider and his Rs amount to requesting user
            const userId = bid['userId'];

            //here keep .to(requesting user socket.id)
            console.log(requestUserId[userId]);
            socket.to(requestUserId[userId]).emit('bid', bid);
            //this will emit bid in frontend
        });
        //now user will select a rider
        socket.on('riderSelected', async (rider) => {
            //from the riderId object, find the rider 
            console.log("Rider:" + rider);
            const id = rider['riderId'];

            await rideController.rideRecordFromSocket({
                userId: rider.userId,
                riderId: rider.riderId,
                from: rider.from,
                to: rider.to,
                finalBid: rider.amount
            }, socket)
            //.to(found rider socket id)
            socket.to(riderId[id]).emit('success-accepted', rider);
            //handle this in frontend
        })

    });
}

module.exports = initializeSocketIO;
