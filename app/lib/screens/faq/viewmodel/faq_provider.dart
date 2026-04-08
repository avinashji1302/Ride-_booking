
import 'package:app/screens/faq/model/faq_model.dart';
import 'package:app/screens/faq/repository/faq_repository.dart';
import 'package:flutter/widgets.dart';
class FaqProvider extends ChangeNotifier {
  final FaqRepository repository = FaqRepository();

  bool isLoading = false;

  List<FaqModel> faqList = [];

  Future<void> faqData() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.faq();

      debugPrint("DATA : ${response.success} ${response.data}");

      if (response.success && response.data != null) {
        faqList = response.data!.results;
        debugPrint("DATA : ${response.data!.results}");
      }
    } catch (e) {
      debugPrint("FAQ Error : $e");
    }

    isLoading = false;
    notifyListeners();
  }
}