import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';

class LogoutProvider  extends ChangeNotifier{

final ProfileRepository repository;

LogoutProvider({required this.repository});
  //-----------------------------------

  bool isLoading=false;


  Future<void> logout() async{

    isLoading = true;
    notifyListeners();

    final response = await repository.logout();
     isLoading=true;
      AuthStorage().clear();


  }

}