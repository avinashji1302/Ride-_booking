import 'package:app/screens/address/model/address_model.dart';
import 'package:app/screens/address/repository/address_repository.dart';
import 'package:flutter/material.dart';
class AddressProvider extends ChangeNotifier {
  final AddressRepository repository = AddressRepository();

  List<AddressModel> addresses = [];

  bool isLoading = false;
  String? error;

  /// FETCH
  Future<void> fetchAddress() async {
    try {
      isLoading = true;
      notifyListeners();

      addresses = await repository.getAddresses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ADD
  Future<void> addAddress(Map<String, dynamic> body) async {
    await repository.addAddress(body);
    await fetchAddress();
  }

  /// UPDATE
  Future<void> updateAddress(
      String id, Map<String, dynamic> body) async {
    await repository.updateAddress(id, body);
    await fetchAddress();
  }

  /// DELETE
  Future<void> deleteAddress(String id) async {
    await repository.deleteAddress(id);
    await fetchAddress();
  }

  /// DEFAULT
  Future<void> makeDefault(String id) async {
    await repository.makeDefault(id);
    await fetchAddress();
  }
}