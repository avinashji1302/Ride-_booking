import 'package:app/screens/audio/viewmodel/audiocall_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AudioCallScreen extends StatefulWidget {
  final String channelName;
  final String token;
  final String rideId;
  final bool isCaller;
  final String callerLabel;   // "Driver" or "User"
  final String receiverLabel; // "User" or "Driver"

  const AudioCallScreen({
    super.key,
    required this.channelName,
    required this.token,
    required this.rideId,
    required this.isCaller,
    required this.callerLabel,
    required this.receiverLabel,
  });

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioCallProvider>().initCall(
        channel: widget.channelName,
        token: widget.token,
        rideId: widget.rideId,
        isCaller: widget.isCaller,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AudioCallProvider>();

    // ✅ Clear UI: who called whom
    final topLabel = widget.isCaller
        ? "You called ${widget.receiverLabel}"
        : "${widget.callerLabel} called you";

    final statusText = !provider.isJoined
        ? "Connecting..."
        : provider.remoteJoined
            ? "Connected ✓"
            : widget.isCaller
                ? "Ringing..."
                : "Joining...";

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.call,
              color: provider.remoteJoined ? Colors.green : Colors.orange,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(topLabel,
                style:
                    const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),
            Text(statusText,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // MUTE
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[800],
                      child: IconButton(
                        icon: Icon(
                          provider.isMuted ? Icons.mic_off : Icons.mic,
                          color: Colors.white,
                        ),
                        onPressed: provider.toggleMute,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      provider.isMuted ? "Unmute" : "Mute",
                      style: const TextStyle(
                          color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                // END CALL
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: const Icon(Icons.call_end,
                            color: Colors.white, size: 28),
                        onPressed: () async {
                          await provider.endCall();
                          if (context.mounted) Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text("End",
                        style: TextStyle(
                            color: Colors.red, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}