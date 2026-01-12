// import 'package:app/config/colors/app_color.dart';
// import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
// import 'package:app/screens/Auth/View/signup/profile_page.dart';
// import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
// import 'package:flutter/material.dart';

// class SetPasswordPage extends StatelessWidget {
//   const SetPasswordPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//         leading: const BackButton(),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Text(
//                 "Set Password",
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               const Text("Set Your Password", style: TextStyle(fontSize: 16 , color: Colors.grey),),
          
//               const SizedBox(height: 24),
          
//               InputfieldWidget(hint: "Enter Your Password", isDropdown: false , icon: Icon(Icons.remove_red_eye),),
//                 const SizedBox(height: 14),
//               InputfieldWidget(hint: "Enter Confirm Password", isDropdown: false , icon: Icon(Icons.remove_red_eye)),
//               Text("Altlease one uppercase,special character and one digit.",
//                   style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          
//               /// Phone field
//               const SizedBox(height: 20),

//               Spacer(),
             
//               /// Sign up button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.primaryYellow,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProfilePage(),
//                       ),
//                     );
//                   },
//                   child: const Text("Register",
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: AppColor.black)),
//                 ),
//               ),

//                const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
