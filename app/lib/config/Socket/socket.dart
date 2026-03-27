import 'package:app/config/network/api_endpoints.dart';
import 'package:app/main.dart';
import 'package:app/screens/audio/view/audio_call_screen.dart';
import 'package:app/screens/audio/view/calling_screen.dart';
import 'package:app/screens/chat/viewModel/chat_provider.dart';
import 'package:app/screens/chat/viewModel/chat_state.dart';
import 'package:app/screens/home/model/ride_accepted_socket_model.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance =
      SocketService._internal(); // creating an instance
  factory SocketService() =>
      _instance; // assign the same instance every time to SocketService so that
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
      final rideId = rideDetails.ride.id;
      debugPrint("data revived : $rideId jpoined............");
      joinRoom(rideId);
      // recievedMessage();
    });

    socket!.onDisconnect((_) {
      debugPrint("🔴 SOCKET DISCONNECTED");
    });

    //

    socket!.on("user:driverArrived", (data) {
      debugPrint("Driver is arrived: $data");

      if (_homeProvider.flow != HomeFlow.driverArrived) {
        _homeProvider.setRideStatus();
      }
    });

    socket!.on("user:rideStarted", (data) {
      debugPrint("ride started: $data");

      _homeProvider.rideStarted();
    });

    //   // REACHED DESTINATION
    socket!.on("user:reachedDestination", (data) async {
      debugPrint("🏁 reached desination : ${data['ride']}");
      // _homeProvider.onReachedAtDestination(data['ride']);

      _homeProvider.reachedDestination();
      await _homeProvider.getDuePayment(
        _homeProvider.confiremRideDetails!.ride.id,
      );
    });
    //   // RIDE COMPLETED;
    socket!.on("user:rideCompleted", (data) {
      debugPrint("🏁 Ride Completed: $data");
      _homeProvider.showRatingSheet();
    });

    socket!.on("user:rideCancelled", (data) {
      debugPrint("❌ Ride Cancelled by user........: ${data['ride']}");
    });

    _registerChatListeners();

    /// 🔥 ADD THESE
    // listenIncomingCall();
    // // listenCallAccepted();
    // listenCallEnded();
    // listenCallAcceptedAsReceiver();

    listenIncomingCall();
    listenCallAccepted();
    listenCallRejected();
    listenCallEnded();
  }

  void disconnect() {
    debugPrint("🔌 Socket disconnected manually");
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }

  void _registerChatListeners() {
    socket!.off("ride:receiveMessage"); // ⭐ IMPORTANT FIX
    socket!.on("ride:receiveMessage", (data) {
      debugPrint("📩 USER MESSAGE: $data");
      final senderType = data['senderType'];
      final msg = data['text'];
      final rideId = data['ride'].toString();

      if (senderType == "user") return; // skip own

      ChatProvider.instance.addMessage(data);

      if (!ChatState.isChatOpen) {
        ChatProvider.instance.showPopup(msg, rideId);
      }
    });
  }

  void joinRoom(String rideId) {
    debugPrint("driver accepted ride joined room with id : $rideId.......");
    socket!.emit("ride:joinRoom", rideId);
  }

  void sendMessage(String rideId, String message) {
    debugPrint("sending message ....... $message to the rideId : $rideId");
    socket!.emit("ride:sendMessage", {'rideId': rideId, 'text': message});
  }

  //----------------------audio call-----------------------------------------

  // ================= AUDIO CALL (COMMON FOR USER + DRIVER) =================

  // ================= AUDIO CALL (COMMON FOR USER + DRIVER) =================

  // ─────────────────────────────────────────────────
  // USER SOCKET — Audio Call
  // ─────────────────────────────────────────────────

  bool _iAmTheCaller = false;

  void startAudioCall(String rideId) {
    _iAmTheCaller = true;
    debugPrint("📞 USER starting call");
    socket!.emit("ride:startAudioCall", {"rideId": rideId});

    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (_) => CallingScreen(
          callerLabel: "Calling Driver...",
          onCancel: () {
            _iAmTheCaller = false;
            Navigator.pop(navigatorKey.currentContext!);
          },
        ),
      ),
    );
  }

  void listenIncomingCall() {
    socket!.off("ride:incomingAudioCall");
    socket!.on("ride:incomingAudioCall", (data) {
      debugPrint("📞 USER got incomingAudioCall — iAmCaller: $_iAmTheCaller");

      // ✅ I started this call — skip dialog
      if (_iAmTheCaller) return;

      // ✅ Driver called me — show dialog
      final rideId = data['rideId'] as String;
      final callId = data['callId'] as String;

      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            "📞 Incoming Call",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Driver is calling you",
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                acceptAudioCall(rideId, callId);
                Navigator.pop(navigatorKey.currentContext!);
              },
              child: const Text(
                "Accept",
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                rejectAudioCall(rideId, callId);
                Navigator.pop(navigatorKey.currentContext!);
              },
              child: const Text("Reject", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    });
  }

  void listenCallAccepted() {
    socket!.off("ride:audioCallAccepted");
    socket!.on("ride:audioCallAccepted", (data) {
      debugPrint("✅ USER audioCallAccepted — iAmCaller: $_iAmTheCaller");

      final rideId = data['rideId'] as String;
      final channel = data['channel'] as String;

      // ✅ Caller uses callerToken (uid=0), receiver uses receiverToken (uid=1)
      final token = _iAmTheCaller
          ? data['callerToken'] as String
          : data['receiverToken'] as String;

      if (_iAmTheCaller) {
        Navigator.pop(navigatorKey.currentContext!); // pop CallingScreen
      }

      final wasCaller = _iAmTheCaller;
      _iAmTheCaller = false; // reset before navigation

      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (_) => AudioCallScreen(
            channelName: channel,
            token: token,
            rideId: rideId,
            isCaller: wasCaller,
            callerLabel: wasCaller ? "User" : "Driver",
            receiverLabel: wasCaller ? "Driver" : "User",
          ),
        ),
      );
    });
  }

  void acceptAudioCall(String rideId, String callId) {
    socket!.emit("ride:acceptAudioCall", {"rideId": rideId, "callId": callId});
  }

  void rejectAudioCall(String rideId, String callId) {
    _iAmTheCaller = false;
    socket!.emit("ride:rejectAudioCall", {"rideId": rideId, "callId": callId});
  }

  void endAudioCall(String rideId, String callId) {
    _iAmTheCaller = false;
    socket!.emit("ride:endAudioCall", {"rideId": rideId, "callId": callId});
  }

  void listenCallRejected() {
    socket!.off("ride:audioCallRejected");
    socket!.on("ride:audioCallRejected", (data) {
      debugPrint("❌ USER call rejected");
      _iAmTheCaller = false;
      if (navigatorKey.currentContext != null) {
        Navigator.pop(navigatorKey.currentContext!);
      }
    });
  }

  void listenCallEnded() {
    socket!.off("ride:audioCallEnded");
    socket!.on("ride:audioCallEnded", (data) {
      debugPrint("🔚 USER call ended");
      _iAmTheCaller = false;
      if (navigatorKey.currentContext != null) {
        Navigator.pop(navigatorKey.currentContext!);
      }
    });
  }

  //   void startAudioCall(String rideId) {
  //     debugPrint("📞 Starting call: $rideId");

  //     socket!.emit("ride:startAudioCall", {"rideId": rideId});
  //   }

  // void listenIncomingCall() {
  //   socket!.off("ride:incomingAudioCall");

  //   socket!.on("ride:incomingAudioCall", (data) {
  //     debugPrint("📞 User got incomingAudioCall: $data");

  //     final rideId = data['rideId'] as String;
  //     final callId = data['callId'] as String;

  //     // ✅ User only shows dialog when driver is calling them
  //     if (data['callerType'] != 'driver') return;

  //     showDialog(
  //       context: navigatorKey.currentContext!,
  //       barrierDismissible: false,
  //       builder: (_) => AlertDialog(
  //         title: const Text("Incoming Call"),
  //         content: const Text("Driver is calling you"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               acceptAudioCall(rideId, callId);
  //               Navigator.pop(navigatorKey.currentContext!);
  //               // ✅ Don't navigate here — wait for ride:audioCallAccepted
  //             },
  //             child: const Text("Accept"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               rejectAudioCall(rideId, callId);
  //               Navigator.pop(navigatorKey.currentContext!);
  //             },
  //             child: const Text("Reject"),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  // // ✅ User (receiver) listens here and uses receiverToken
  // void listenCallAcceptedAsReceiver() {
  //   socket!.off("ride:audioCallAccepted");

  //   socket!.on("ride:audioCallAccepted", (data) {
  //     debugPrint("✅ User got audioCallAccepted: $data");

  //     final rideId = data['rideId'] as String;
  //     final receiverToken = data['receiverToken'] as String; // ✅ user uses receiverToken
  //     final channel = data['channel'] as String;

  //     Navigator.push(
  //       navigatorKey.currentContext!,
  //       MaterialPageRoute(
  //         builder: (_) => AudioCallScreen(
  //           channelName: channel,
  //           token: receiverToken, // ✅ receiverToken for user
  //           rideId: rideId,
  //           isCaller: false, // ✅ user is receiver
  //         ),
  //       ),
  //     );
  //   });
  // }

  //   /// ACCEPT CALL
  //   void acceptAudioCall(String rideId, String callId) {
  //     debugPrint(" Call Accepted: $rideId  callId $callId");

  //     socket!.emit("ride:acceptAudioCall", {"rideId": rideId, "callId": callId});
  //   }

  //   /// REJECT
  //   void rejectAudioCall(String rideId, String callId) {
  //     socket!.emit("ride:rejectAudioCall", {"rideId": rideId, "callId": callId});
  //   }

  //   /// END CALL
  //   void endAudioCall(String rideId, String callId) {
  //     socket!.emit("ride:endAudioCall", {"rideId": rideId, "callId": callId});
  //   }

  //   /// CALL ENDED
  //   void listenCallEnded() {
  //     socket!.on("ride:audioCallEnded", (data) {
  //       debugPrint("❌ Call Ended: $data");

  //       Navigator.pop(navigatorKey.currentContext!);
  //     });
  //   }
}
