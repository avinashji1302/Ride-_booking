import 'package:app/config/Socket/socket.dart';
import 'package:app/main.dart';
import 'package:app/screens/chat/view/chat_screen.dart';
import 'package:flutter/material.dart';

// import 'package:app/services/socket_service.dart';
class ChatProvider extends ChangeNotifier {
  static final ChatProvider instance = ChatProvider._internal();
  ChatProvider._internal();

  List<Map<String, dynamic>> messages = [];
  Set<String> messageIds = {}; // 🔥 prevent duplicate

  /// ADD MESSAGE FROM SOCKET (GLOBAL)
  void addMessage(dynamic data) {
    final id = data['_id'];
    debugPrint("message : $id $data ");
    if (messageIds.contains(id)) {
      debugPrint("⚠️ Duplicate skipped: $id");
      return;
    }

    messageIds.add(id);

    final msg = data['text'];
    final senderType = data['senderType'];

    final isMe = senderType == "user";

    messages.insert(0, {"message": msg, "isMe": isMe, "time": DateTime.now()});

    notifyListeners();
  }

  /// SEND MESSAGE
  void sendMessage(String rideId, String message) {
    debugPrint("sending message with rid : $rideId");
    if (message.trim().isEmpty) return;

    final tempId = DateTime.now().toString();
    messageIds.add(tempId);

    messages.insert(0, {
      "message": message,
      "isMe": true,
      "time": DateTime.now(),
    });

    notifyListeners();

    SocketService().sendMessage(rideId, message);
  }

  /// 🔔 POPUP
  // void showPopup(String message, String rideId) {
  //   final context = navigatorKey.currentContext;

  //   if (context == null) return;

  //   final overlay = Overlay.of(context);

  //   late OverlayEntry entry;

  //   entry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       top: 50,
  //       left: 10,
  //       right: 10,
  //       child: GestureDetector(
  //         onTap: () {
  //           entry.remove();

  //           /// 👉 Navigate to chat
  //           navigatorKey.currentState!.push(
  //             MaterialPageRoute(
  //               builder: (_) => ChatScreen(rideId: rideId),
  //             ),
  //           );
  //         },
  //         child: Material(
  //           color: Colors.transparent,
  //           child: Container(
  //             padding: const EdgeInsets.all(14),
  //             decoration: BoxDecoration(
  //               color: Colors.black,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Text(
  //               message,
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

  //   overlay.insert(entry);

  //   /// Auto remove after 3 sec
  //   Future.delayed(const Duration(seconds: 3), () {
  //     if (entry.mounted) {
  //       entry.remove();
  //     }
  //   });
  // }

  void showPopup(String message, String rideId) {
    final overlay = navigatorKey.currentState?.overlay;

    if (overlay == null) {
      debugPrint("❌ No overlay found");
      return;
    }

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 10,
        right: 10,
        child: GestureDetector(
          onTap: () {
            entry.remove();

            navigatorKey.currentState!.push(
              MaterialPageRoute(builder: (_) => ChatScreen(rideId: rideId)),
            );
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Icon(Icons.person , color: Colors.white,),
                  // SizedBox(width: 20,),
                  Text(message, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 3), () {
      if (entry.mounted) {
        entry.remove();
      }
    });
  }
}
