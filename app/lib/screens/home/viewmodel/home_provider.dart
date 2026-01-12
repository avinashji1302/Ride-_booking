// import 'dart:convert';

// import 'package:app/config/api_constants.dart';
// import 'package:app/config/shared_pref.dart';
// import 'package:app/screens/home/model/home_model.dart';
// import 'package:flutter/foundation.dart';
// // import 'package:http/http.dart' as http show get;

// class HomeProvider extends ChangeNotifier {
//   List<Order> orders = [];
//   bool isLoading = false;
//   String? error;

//   Future<void> getOrders() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final token = await SharedPref().getToken() ?? "";
//       debugPrint("Token in url: ${ApiConstants.baseUrl}/orders/my");

//       debugPrint("Token in HomeProvider: $token");

//       final response = await http.get(
//         Uri.parse("${ApiConstants.baseUrl}/orders/my"),
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         orders = (data['orders']['data'] as List)
//             .map((e) => Order.fromJson(e))
//             .toList();
//         error = null;
//       } else {
//         error = "Failed to load orders";
//       }
//     } catch (e) {
//       error = e.toString();
//     }

//     isLoading = false;
//     notifyListeners();
//   }


  
// }

