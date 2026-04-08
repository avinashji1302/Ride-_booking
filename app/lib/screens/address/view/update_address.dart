import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/common_button.dart';
import 'package:app/config/helper/common/common_text_field.dart';
import 'package:app/screens/address/model/address_model.dart';
import 'package:app/screens/address/viewmodel/address_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? address;

  const AddAddressScreen({super.key, this.address});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final addressController = TextEditingController();
  final areaController = TextEditingController();
  final floorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.address != null) {
      addressController.text = widget.address!.completeAddress;
      areaController.text = widget.address!.area;
      floorController.text = widget.address!.floor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address == null ? "Add Address" : "Update Address"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CommonTextField(hintText: "Address", controller: addressController),
            const SizedBox(height: 10),
            CommonTextField(hintText: "Area", controller: areaController),
            const SizedBox(height: 10),
            CommonTextField(hintText: "Floor", controller: floorController),

            const SizedBox(height: 20),

            CommonButton(
              title: widget.address == null ? "Add Address" : "Update Address",
              backgroundColor: AppColor.primaryYellow,
              onPressed: () async {
                final body = {
                  "addressType": "home",
                  "zipCode": "302001",
                  "completeAddress": addressController.text,
                  "area": areaController.text,
                  "floor": floorController.text,
                  "defaultAddress": false,
                  "latitude": 26.9124,
                  "longitude": 75.7873,
                };

                final provider = context.read<AddressProvider>();

                if (widget.address == null) {
                  await provider.addAddress(body);
                } else {
                  await provider.updateAddress(widget.address!.id, body);
                }

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
