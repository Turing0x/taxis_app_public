// ignore_for_file: avoid_print

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {

  io.Socket socket = io.io(
    Uri.https(dotenv.env['SERVER_URL']!).toString(),
    io.OptionBuilder()
      .setTransports(['websocket'])
      .build());

  initConnection() {

    socket.connect();
    socket.on('connection', (_) {
      print('connect ${_.toString()}');
    });

    socket.onConnect((_) {
      print('connect');
    });

    socket.onerror((_) {
      print('Error Is ${_.toString()}');
    });
  }

}