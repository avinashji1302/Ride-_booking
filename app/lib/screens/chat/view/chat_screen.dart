import 'package:app/screens/chat/viewModel/chat_provider.dart';
import 'package:app/screens/chat/viewModel/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatScreen extends StatefulWidget {
  final String rideId;

  const ChatScreen({super.key, required this.rideId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

@override
void initState() {
  super.initState();

  ChatState.isChatOpen = true;
}

@override
void dispose() {
  ChatState.isChatOpen = false;
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("User Chat")),
      body: SafeArea(
        child: Column(
          children: [
        
            /// 💬 MESSAGES
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: provider.messages.length,
                itemBuilder: (context, index) {
                  final msg = provider.messages[index];
        
                  return Align(
                    alignment: msg["isMe"]
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg["isMe"]
                            ? Colors.blue
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg["message"],
                        style: TextStyle(
                          color: msg["isMe"]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        
            /// ✍️ INPUT
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Type message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    provider.sendMessage(
                      widget.rideId,
                      messageController.text,
                    );
                    messageController.clear();
                  },
                )
              ],
            ),
        
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}