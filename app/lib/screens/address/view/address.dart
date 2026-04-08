import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/address/view/update_address.dart';
import 'package:app/screens/address/viewmodel/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AddressProvider>().fetchAddress());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("My Addresses") , backgroundColor:  Colors.white,),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddAddressScreen(),
            ),
          );
        },
        label: const Text("Add Address"),
        icon: const Icon(Icons.add),
      ),

      body: Consumer<AddressProvider>(
        builder: (_, provider, __) {

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          }

          return ListView.builder(
            itemCount: provider.addresses.length,
            itemBuilder: (_, index) {

              final address = provider.addresses[index];

              return Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14 ),
                  border: Border.all(color: AppColor.primaryYellow),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black12,
                    )
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TOP ROW
                    Row(
                      children: [

                        Icon(
                          address.addressType == "home"
                              ? Icons.home
                              : Icons.work,
                              color: AppColor.primaryYellow,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          address.addressType.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),

                        const Spacer(),

                        if (address.defaultAddress)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "DEFAULT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(address.completeAddress),

                    Text("Floor: ${address.floor}"),

                    const SizedBox(height: 12),

                    /// ACTION BUTTONS
                    Row(
                      children: [

                        TextButton.icon(
                          icon: const Icon(Icons.edit , color: AppColor.grey,),
                          label: const Text("Edit"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddAddressScreen(
                                      address: address,
                                    ),
                              ),
                            );
                          },
                        ),

                        TextButton.icon(
                          icon: const Icon(Icons.delete,
                              color: Colors.red),
                          label: const Text("Delete"),
                          onPressed: () {
                            context
                                .read<AddressProvider>()
                                .deleteAddress(address.id);
                          },
                        ),

                        const Spacer(),

                        if (!address.defaultAddress)
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AddressProvider>()
                                  .makeDefault(address.id);
                            },
                            child: const Text("Make Default"),
                          ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}