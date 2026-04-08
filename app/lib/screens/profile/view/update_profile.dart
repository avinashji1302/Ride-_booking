import 'dart:io';

import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/common_button.dart';
import 'package:app/config/helper/common/common_text_field.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  final String fullName;
  final String profilePic;
  final String address;

  const UpdateProfile({
    super.key,
    required this.fullName,
    required this.profilePic,
    required this.address,
  });

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    super.initState();
    // ✅ Initialize controllers when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      provider.initializeControllers(widget.fullName, widget.address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile"), centerTitle: true),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text("Camera"),
                                onTap: () {
                                  Navigator.pop(context);
                                  provider.pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text("Gallery"),
                                onTap: () {
                                  Navigator.pop(context);
                                  provider.pickImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColor.lightyellow,
                        backgroundImage: provider.selectedImage != null
                            ? FileImage(File(provider.selectedImage!.path))
                            : NetworkImage(provider.userDetails!.profilePic),
                        child: provider.selectedImage == null
                            ? Icon(
                                Icons.person,
                                size: 42,
                                color: Colors.transparent,
                              )
                            : null,
                      ),

                      Positioned(
                        top:40,
                        right: 0,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.grey.withOpacity(0.4),
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: AppColor.primaryYellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CommonTextField(
                  controller: provider.nameController,
                  hintText: 'Enter Updated Name',
                ),

                // CommonTextField(
                //   controller: provider
                //       .addressController, // ✅ Fix: Use addressController
                //   hintText: 'Enter Updated Address',
                // ),

                //  const SizedBox(height: 30),
                Spacer(),

                // Container(
                //   color: AppColor.primaryYellow,
                //   child: GestureDetector(
                //     onTap: () async {
                //       debugPrint(
                //         "result........... : ${provider.addressController} ${provider.nameController}",
                //       );
                //       final result = await provider.updateProfile(
                //         provider.nameController!.text,
                //       );
                //       debugPrint("result : $result");

                //       if (result.success) {
                //         await provider.getProfile();
                //         Navigator.of(context).pop();
                //       }
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Center(
                //         child: provider.isLoading
                //             ? SizedBox(
                //                 width: 20,
                //                 height: 20,
                //                 child: CircularProgressIndicator(
                //                   color: AppColor.lightGrey,
                //                   strokeWidth: 3,
                //                 ),
                //               )
                //             : Text(
                //                 "Update",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //       ),
                //     ),
                //   ),
                // ),
                CommonButton(
                  title: "Update",
                  onPressed: () async {
                    debugPrint(
                      "result........... : ${provider.addressController} ${provider.nameController}",
                    );
                    final result = await provider.updateProfile(
                      provider.nameController!.text,
                    );
                    debugPrint("result : $result");

                    if (result.success) {
                      await provider.getProfile();
                      Navigator.of(context).pop();
                      provider.selectedImage = null;
                    }
                  },
                  backgroundColor: AppColor.primaryYellow,
                ),

                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
