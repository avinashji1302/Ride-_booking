// import 'package:app/config/colors/app_color.dart';
// import 'package:app/screens/Auth/View/signIn/varify_email_phone_page.dart';
// import 'package:flutter/material.dart';

// class ForgettenPasswordList extends StatelessWidget {
//   const ForgettenPasswordList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: const BackButton(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             const SizedBox(height: 40),

//             const Text(
//               "Forget Password",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               textAlign: TextAlign.center,
//               "Selecte which contact details we should use to reset you password",
//               style: TextStyle(color: Colors.grey),
//             ),

//             SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFF6DD),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppColor.primaryYellow, width: 1.2),
//               ),
//               child: Row(
//                 children: [
//                   /// Icon
//                   Container(
//                     width: 44,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       color: AppColor.white.withOpacity(0.15),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(Icons.message, color: AppColor.primaryYellow),
//                   ),

//                   const SizedBox(width: 16),

//                   /// Text
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Via Sms",
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "638897****",
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 15),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFF6DD),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppColor.primaryYellow, width: 1.2),
//               ),
//               child: Row(
//                 children: [
//                   /// Icon
//                   Container(
//                     width: 44,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       color: AppColor.white.withOpacity(0.15),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(Icons.email, color: AppColor.primaryYellow),
//                   ),

//                   const SizedBox(width: 16),

//                   /// Text
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Via Email",
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "avi****@gmail.com",
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const Spacer(),

//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 50),
//                 backgroundColor: AppColor.primaryYellow,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => VarifyEmailPhonePage(),
//                 //   ),
//                 // );
//               },
//               child: Text("Varify", style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget otpBox() {
//   return SizedBox(
//     height: 40,
//     width: 40,
//     child: TextField(
//       keyboardType: TextInputType.numberWithOptions(),
//       decoration: InputDecoration(border: OutlineInputBorder()),
//     ),
//   );
// }
