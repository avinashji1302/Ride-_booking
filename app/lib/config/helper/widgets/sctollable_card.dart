import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SctollableCard extends StatelessWidget {
  const SctollableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeProvider>();
    return DraggableScrollableSheet(
      // key: _sheet,
      initialChildSize: 0.5,
      maxChildSize: 1,
      minChildSize: 0,
      expand: true,
      snap: true,
      snapSizes: const [0.5],
      // controller: _controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Card(child: Container(width: 90, height: 10, color: Colors.red)),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.red),
                    hintText: "Enter Destination",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),

                  onChanged: (value) {},
                ),
              ),

              // all recent item
              Consumer(
                builder: (BuildContext context, controller, Widget? child) {
                  return Expanded(
                    child: Card(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Expanded(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text(
                                    "Jaipur Railway Station , Gopalganj",
                                  ),
                                  subtitle: Text("Jaipur Internation Airport"),
                                  onTap: () async {

                                    print("Tapped...");
                                    final ressult = await home
                                        .getAllEstimtedData();


                                        print("Tapped... ${ressult.message}");

                                    if (ressult.success) {
                                      AppSnackBar.show(
                                        context,
                                        message: ressult.message,
                                      );
                                      home.goToRideSelection();
                                    } else {
                                      AppSnackBar.show(
                                        context,
                                        message: ressult.message,
                                      );
                                    }
                                  },
                                ),
                                Divider(color: Colors.grey.shade300),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
