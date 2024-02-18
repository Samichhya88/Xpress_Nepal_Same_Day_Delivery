import 'dart:async';

import 'package:same_day_delivery_client/services/api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StreamSocket {
  final _socketResponse = StreamController<List<dynamic>>();

  void Function(List<dynamic>) get addResponse => _socketResponse.sink.add;

  Stream<List<dynamic>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

late IO.Socket socket;
void socketInit() {
  socket = IO.io(ApiService().baseUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  socket.connect();
  socket.onConnect((_) {
    print('connected');
    socket.emit('msg', 'test');
  });

  socket.onDisconnect((_) => print('disconnect'));
}
