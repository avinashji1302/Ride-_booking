import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class DeviceDetails {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  // static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
          debugPrint('Anrodid  device ID: ${androidInfo.id}');
        return androidInfo.id; // Unique Android ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
         debugPrint('iosInfo.identifierForVendor ID: ${iosInfo.identifierForVendor }');
        return iosInfo.identifierForVendor ?? ''; // Unique iOS ID
      }
      return 'unknown';
    } catch (e) {
      debugPrint('Error getting device ID: $e');
      return 'unknown';
    }
  }

  // /// Get FCM token
  // static Future<String?> getFcmToken() async {
  //   try {
  //     // Request permission first
  //     NotificationSettings settings = await _firebaseMessaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,
  //     );
  //
  //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //       debugPrint('✅ FCM Permission granted');
  //
  //       // Get FCM token
  //       String? token = await _firebaseMessaging.getToken();
  //       debugPrint('📱 FCM Token: $token');
  //       return token;
  //     } else {
  //       debugPrint('❌ FCM Permission denied');
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('❌ Error getting FCM token: $e');
  //     return null;
  //   }
  // }
}