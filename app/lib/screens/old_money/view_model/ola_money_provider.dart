import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/old_money/model/upi_payemnt_response_model.dart';
import 'package:app/screens/old_money/repository/ola_money_repository.dart';
import 'package:flutter/material.dart';

class OlaMoneyProvider extends ChangeNotifier {
  final OlaMoneyRepository repository = OlaMoneyRepository();
  final amountController = TextEditingController();
  final transectionIdController = TextEditingController();
  final upiIdController = TextEditingController();
  final noteController = TextEditingController();

  UpiPayemntResponseModel? adminUpiDetails;
  bool isLoading = false;

  Future<ApiResponse> getAdminPayemnt() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.getAdminPaymentDetails();

      if (response.data != null) {
        adminUpiDetails = response.data;
      }

      isLoading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      debugPrint("error : ${e.toString()}");
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }
  }

  // recharge 
  Future<ApiResponse> walletRecharge() async {
    isLoading = true;
    notifyListeners();

    debugPrint(
      "amount ${amountController.text} trnasection id: ${transectionIdController.text} upicontroller : ${upiIdController.text} note : ${noteController.text}",
    );

    try {
      final response = await repository.wallerRecharge(
        amountController.text,
        transectionIdController.text,
        upiIdController.text,
        noteController.text,
      );

      if (response.data != null) {
        adminUpiDetails = response.data;
        amountController.clear();
        transectionIdController.clear();
        upiIdController.clear();
        noteController.clear();
      }

      isLoading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      debugPrint("error : ${e.toString()}");
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }
  }
}
