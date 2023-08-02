import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final String userEmail;
  final String model;

  SocketService(this.userEmail, this.model) {
    initializeSocket();
  }

  void initializeSocket() {
    socket = IO.io(
      'http://192.168.1.65:3002',
      IO.OptionBuilder().setTransports(['websocket']).setQuery({
        'userEmail': userEmail,
        'uid': model,
      }).build(),
    );

    socket.connect();

    socket.onConnect((data) {
      socket.emit('connection', {
        'userEmail': userEmail,
        'uid': model,
      });
    });

    socket.onDisconnect((_) => print('Disconnected from server'));
  }

  // getter

  IO.Socket get getSocket => socket;

  void dispose() {
    socket.disconnect();
  }
}
