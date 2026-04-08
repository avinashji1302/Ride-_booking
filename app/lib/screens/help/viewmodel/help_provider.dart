import 'package:app/screens/help/model/help_model.dart';
import 'package:app/screens/help/repository/help_repository.dart';
import 'package:flutter/material.dart';

class HelpProvider extends ChangeNotifier {
  final HelpRepository repository = HelpRepository();

  bool isLoading = false;

  List<HelpModel> pages = [];

  Future<void> loadPages() async {
    isLoading = true;
    notifyListeners();

    final response = await repository.getStaticSlug();

    if (response.success && response.data != null) {
      pages = response.data!.pages;
    }

    isLoading = false;
    notifyListeners();
  }
}