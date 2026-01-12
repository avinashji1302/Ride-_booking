// import 'package:app/Notifcation/firebase_notifcation.dart';
// import 'package:app/screens/home/viewmodel/home_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<HomeProvider>().getOrders();
//     });

//     FirebaseNotifcation().initFirebaseNotification();
//   }

//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case "completed":
//         return Colors.green;
//       case "pending":
//         return Colors.orange;
//       case "cancelled":
//         return Colors.red;
//       default:
//         return Colors.blueGrey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: Text("Orders"),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Consumer<HomeProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return Center(
//               child: Text(
//                 provider.error!,
//                 style: TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             );
//           }

//           if (provider.orders.isEmpty) {
//             return Center(
//               child: Text(
//                 "No orders found",
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: EdgeInsets.all(12),
//             itemCount: provider.orders.length,
//             itemBuilder: (_, i) {
//               final order = provider.orders[i];

//               return Container(
//                 margin: EdgeInsets.only(bottom: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 6,
//                       offset: Offset(0, 4),
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       /// Top Row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Order #${order.id}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: _statusColor(order.status)
//                                   .withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               order.status.toUpperCase(),
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: _statusColor(order.status),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 8),

//                       /// Order Info
//                       Row(
//                         children: [
//                           Icon(Icons.person_outline, size: 18),
//                           SizedBox(width: 6),
//                           Text(order.customerName),
//                           Spacer(),
//                           Icon(Icons.table_restaurant_outlined, size: 18),
//                           SizedBox(width: 4),
//                           Text("Table ${order.tableNumber}"),
//                         ],
//                       ),

//                       SizedBox(height: 12),

//                       /// Items
//                       Text(
//                         "Items",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       ...order.items.map(
//                         (e) => Padding(
//                           padding: const EdgeInsets.only(bottom: 4),
//                           child: Row(
//                             children: [
//                               Icon(Icons.circle, size: 6),
//                               SizedBox(width: 8),
//                               Expanded(
//                                 child: Text("${e.name} x ${e.quantity}"),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       Divider(height: 24),

//                       /// Total
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Total",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                             "₹${order.price}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
