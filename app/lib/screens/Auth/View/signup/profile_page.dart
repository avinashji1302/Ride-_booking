// import 'package:app/config/colors/app_color.dart';
// import 'package:app/screens/Auth/View/signIn/forget_pasword_page.dart';
// import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
// import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//         leading: const BackButton(),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsetsGeometry.all(20),
//           child: Column(
//             children: [
//               Stack(
//                 children: [const CircleAvatar(
//                   backgroundImage: NetworkImage(
//                     "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg",
//                   ), //NetworkImage
//                   radius: 60,
//                 ),
//                 Positioned(bottom: 0, right: 0,child:  CircleAvatar(
//                   backgroundColor: AppColor.primaryYellow,
//                   radius: 18,
//                   child: Icon(Icons.camera_alt , color: AppColor.white,)),)
//                 ]
//               ),
//               const SizedBox(height:15),
//               // InputfieldWidget(
//               //   controller: resgisterPriovider.name,
//               //   hint: "Name", isDropdown: false),
//               // SizedBox(height: 10),
             

//                SizedBox(height:15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     height: 55,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: const [
//                         Text("🇧🇩"),
//                         SizedBox(width: 6),
//                         Icon(Icons.arrow_drop_down),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//               //     Expanded(
//               //       child: InputfieldWidget(
//               //         hint: "+91- Your mobile number",
//               //         isDropdown: false,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               // const SizedBox(height:15),
//               // const InputfieldWidget(hint: "Email"),
//               // const SizedBox(height:15),
//               // const InputfieldWidget(hint: "City" , icon: Icon(Icons.arrow_drop_down),),
//               // const SizedBox(height:15),
              
//               // const InputfieldWidget(hint: "District" , icon: Icon(Icons.arrow_drop_down)),
//               //  const SizedBox(height:15),
//               // const InputfieldWidget(hint: "Street"),
             
//               const SizedBox(height: 20),

//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.white,
//                         shape: RoundedRectangleBorder(
//                           side: BorderSide(color: AppColor.primaryYellow),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.primaryYellow,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInPage()));
//                       },
//                       child: const Text(
//                         "Save",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               //CircleAvatar
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
