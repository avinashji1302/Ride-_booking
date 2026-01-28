import 'package:app/config/network/api_endpoints.dart';
import 'package:app/screens/home/model/ride_accepted_socket_model.dart';
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

    //   // SEARCHING FOR NEW DRIVER
    socket!.on("user:searchingDriver", (data) {
      debugPrint("🔍 Searching for new driver................: $data");
    });

    socket!.on('user:rideAccepted', (data) {
      debugPrint("🚗 DRIVER ACCEPTED RIDE");
      debugPrint("📦 data without: ${data}");
      debugPrint("📦 Ride Data: ${data['results']}");
      debugPrint("📦 otp: ${data['otp']}");
      debugPrint("📦 driver: ${data['driver']}");
      debugPrint("📦 ride: ${data['ride']}");
      debugPrint("📦 vehicle : ${data['vehicle']}");

      final rideDetails = RideAcceptedSocketModel.fromJson(data);

      debugPrint("📦 ride details : $rideDetails");

      _homeProvider.onRideAccepted(rideDetails);
    });

    socket!.onDisconnect((_) {
      debugPrint("🔴 SOCKET DISCONNECTED");
    });

    //

    socket!.on("user:driverArrived", (data) {
      debugPrint("Driver is arrived: $data");
    });

    socket!.on("user:rideStarted", (data) {
      debugPrint("ride started: $data");
    });

    socket!.on("user:rideCancelled", (data) {
      debugPrint("❌ Ride Cancelled by user........: $data");
    });
  }

  void disconnect() {
    debugPrint("🔌 Socket disconnected manually");
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }
}


// socket.on("user:driverArrived", (data) => {
//     log("📍 Driver Arrived:");
//     logJson("", data);
//   });
 
//   // RIDE STARTED
//   socket.on("user:rideStarted", (data) => {
//     log("🚗 Ride Started:");
//     logJson("", data);
//   });
 
//   // LIVE DRIVER LOCATION
//   socket.on("driver:location", (loc) => {
//     logJson("📍 driver:location", loc);
//   });
 
//   // REACHED DESTINATION
//   socket.on("user:reachedDestination", (data) => {
//     log("📍 Reached Destination:");
//     logJson("", data);
//   });
 
//   // RIDE COMPLETED
//   socket.on("user:rideCompleted", (data) => {
//     log("🏁 Ride Completed:");
//     logJson("", data);
//   });
 
//   // RIDE CANCELLED
//   socket.on("user:rideCancelled", (data) => {
//     log("❌ Ride Cancelled:");
//     logJson("", data);
//   });
 
//   // SEARCHING FOR NEW DRIVER
//   socket.on("user:searchingDriver", (data) => {
//     log("🔍 Searching for new driver:");
//     logJson("", data);
//   });