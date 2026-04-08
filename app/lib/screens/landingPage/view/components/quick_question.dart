// import 'package:flutter/material.dart';

// class QuickDestinations extends StatelessWidget {
//   const QuickDestinations({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final places = [
//       SavedPlace(label: "Home", address: "Jaipur"),
//       SavedPlace(label: "Office", address: "Cyber City"),
//     ];

//     return Column(
//       children: places.map((place) {

//         return ListTile(
//           title: Text(place.label),
//           subtitle: Text(place.address),
//         );

//       }).toList(),
//     );
//   }
// }

// class SavedPlace {
//   final String label;
//   final String address;

//   SavedPlace({
//     required this.label,
//     required this.address,
//   });
// }