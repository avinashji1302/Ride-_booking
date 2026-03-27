
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



class AudioCallProvider extends ChangeNotifier {
  RtcEngine? _engine;
  bool isJoined = false;
  bool isMuted = false;
  bool remoteJoined = false;
  bool _isInitializing = false;

  final String appId = "aa91611b165b46d5854c2f657277f6d7";

  Future<void> initCall({
    required String channel,
    required String token,
    required String rideId,
    required bool isCaller,
  }) async {
    if (_isInitializing) return;
    _isInitializing = true;

    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      debugPrint("❌ Mic permission denied");
      _isInitializing = false;
      return;
    }

    _engine = createAgoraRtcEngine();

    await _engine!.initialize(RtcEngineContext(appId: appId));

    await _engine!.setChannelProfile(
      ChannelProfileType.channelProfileCommunication,
    );

    await _engine!.setClientRole(
      role: ClientRoleType.clientRoleBroadcaster,
    );

    await _engine!.enableAudio();

    // ✅ DO NOT call setEnableSpeakerphone here — call it after joining

    _engine!.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, elapsed) {
        debugPrint("✅ Joined channel uid: ${connection.localUid}");
        isJoined = true;
        notifyListeners();

        // ✅ Safe to call AFTER joining
        _engine?.setEnableSpeakerphone(true);
        _engine?.muteLocalAudioStream(false);
        _engine?.muteAllRemoteAudioStreams(false);
      },
      onUserJoined: (connection, uid, elapsed) {
        debugPrint("👤 Remote joined uid: $uid");
        remoteJoined = true;
        notifyListeners();
      },
      onUserOffline: (connection, uid, reason) {
        debugPrint("❌ Remote left uid: $uid");
        remoteJoined = false;
        notifyListeners();
      },
      onError: (err, msg) {
        debugPrint("❌ Agora error: $err — $msg");
      },
    ));

    // ✅ caller=uid 0 (matches callerToken), receiver=uid 1 (matches receiverToken)
    final int uid = isCaller ? 0 : 1;

    debugPrint("🔗 Joining channel: $channel uid: $uid isCaller: $isCaller");

    await _engine!.joinChannel(
      token: token,
      channelId: channel,
      uid: uid,
      options: const ChannelMediaOptions(
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  void toggleMute() {
    isMuted = !isMuted;
    _engine?.muteLocalAudioStream(isMuted);
    notifyListeners();
  }

  Future<void> endCall() async {
    await _engine?.leaveChannel();
    await _engine?.release();
    _engine = null;
    isJoined = false;
    isMuted = false;
    remoteJoined = false;
    _isInitializing = false;
    notifyListeners();
  }

  @override
  void dispose() {
    endCall();
    super.dispose();
  }
}