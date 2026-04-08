import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/notification/model/notificatation_model.dart';
import 'package:app/screens/notification/repository/notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository notificationRepository =
      NotificationRepository();
  bool isLoading = false;
  bool isEnable=false;

  List<NotificationModel> list = [];

  Future<ApiResponse<NotificationResponse>> getNotification() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await notificationRepository.getNotification();

      if (response.success && response.data != null) {

         debugPrint("data is : ${response.data!.docs}");
        list.addAll(response.data!.docs);

          debugPrint("data is : ${list}");
      }
      isLoading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return ApiResponse(success: false, message: "Sometnhig went wrong : $e");
    }
  }


//---------------------seen notification------------------------------

  Future<ApiResponse<NotificationResponse>> seenNotification(bool value) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await notificationRepository.seenNotification(value);

      if (response.success) {
           isEnable = value;
         debugPrint("seen message $isEnable");
       
      }
      isLoading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return ApiResponse(success: false, message: "Sometnhig went wrong : $e");
    }
  }
}
