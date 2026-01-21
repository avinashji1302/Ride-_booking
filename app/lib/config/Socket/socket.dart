

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? socket;

  late HomeProvider _homeProvider;

  /// Inject provider ONCE
  void attachHomeProvider(HomeProvider provider) {
    _homeProvider = provider;
    debugPrint("🧩 HomeProvider attached to SocketService");
  }

  void connect(String token, String id) {
    if (socket != null && socket!.connected) {
      debugPrint("⚠️ Socket already connected");
      return;
    }

    debugPrint("🔑 Connecting socket...");

    socket = IO.io(
      ApiEndpoints.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .build(),
    );

    _registerListeners(id);
    socket!.connect();
  }

  void _registerListeners(String id) {
    socket!.onAny((event, data) {
      debugPrint("━━━━━━━━━━━━━━━━━━━━");
      debugPrint("📡 EVENT: $event");
      debugPrint("📦 DATA: $data");
      debugPrint("━━━━━━━━━━━━━━━━━━━━");
    });

    socket!.onConnect((_) {
      debugPrint("🟢 SOCKET CONNECTED");
      socket!.emit('user:connect', id);
    });

    socket!.on('user:rideAccepted', (data) {
      debugPrint("🚗 DRIVER ACCEPTED RIDE");
      debugPrint("📦 Ride Data: ${data['ride']}");

      // ✅ SAFE — no context involved
      _homeProvider.onRideAccepted(data['ride']);
    });

    socket!.onDisconnect((_) {
      debugPrint("🔴 SOCKET DISCONNECTED");
    });
  }

  void disconnect() {
    debugPrint("🔌 Socket disconnected manually");
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }
}
