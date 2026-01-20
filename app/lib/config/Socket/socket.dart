import 'dart:math' as console;

import 'package:app/config/network/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? socket;

  // ================= CONNECT =================
  void connect(String token , String id) {
    if (socket != null && socket!.connected) {
      debugPrint("⚠️ Socket already connected");
      return;
    }

    debugPrint("🔑 Connecting socket with token");

    socket = IO.io(
      // 'http://192.168.2.143:5678',

      ApiEndpoints.baseUrl,
      
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({
            'Authorization': 'Bearer $token', 
          })
          .setAuth({
            'token': token, 
          })
          .build(),
    );

    _registerListeners(id);
    socket!.connect();
  }

  // ================= LISTENERS =================
  void _registerListeners(String id) {
    // 🔍 LISTEN TO ALL EVENTS (DEBUG)
    socket!.onAny((event, data) {
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('📨 SOCKET EVENT');
      debugPrint('🏷️ Event: $event');
      debugPrint('📦 Data: $data');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    });



    socket!.onConnect((_) {
      debugPrint('🟢 SOCKET CONNECTED');

      socket!.emit('user:connect', id);
      debugPrint('🆔 Socket ID: ${socket!.id}');
    });

    socket!.onDisconnect((_) {
      debugPrint('SOCKET DISCONNECTED');
    });

    socket!.onConnectError((err) {
      debugPrint('CONNECT ERROR: $err');
    });

    socket!.onError((err) {
      debugPrint('SOCKET ERROR: $err');
    });

    socket!.on('user:rideAccepted', (data) {
      debugPrint('DRIVER ACCEPTED RIDE');
      debugPrint('📦 DATA: $data');
    });

    socket!.on('user:connect:ack', (data) => {
  print('User connected successfully:$data')
  // Now you can receive ride events
});
  }

  // ================= DISCONNECT =================
  void disconnect() {
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }
}
