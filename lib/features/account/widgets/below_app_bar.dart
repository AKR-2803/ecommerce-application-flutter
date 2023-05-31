import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/features/account/services/account_services.dart';

class BelowAppBar extends StatefulWidget {
  const BelowAppBar({super.key});

  @override
  State<BelowAppBar> createState() => _BelowAppBarState();
}

class _BelowAppBarState extends State<BelowAppBar> {
  String? _image;
  AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print("\n-------------------- ImageURL  : ${user.imageUrl}");
    return Container(
      padding: EdgeInsets.only(
        left: mq.width * .035,
        right: mq.width * .025,
        bottom: mq.width * .025,
      ),
      // decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
                text: "Hello, ",
                style: const TextStyle(fontSize: 22, color: Colors.black),
                children: [
                  TextSpan(
                    text: user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * 0.1),
                //display profile picture
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: user.imageUrl == null || user.imageUrl == ""
                      ? const NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnWaCAfSN08VMtSjYBj0QKSfHk4-fjJZCOxgHLPuBSAw&s")
                      : NetworkImage(user.imageUrl!),
                ),
              ),
              // CircleAvatar(
              //   backgroundColor: Colors.deepPurpleAccent,
              //   radius: 25,
              //   child: user.imageUrl == null || user.imageUrl == ""
              //       ? Image.network(
              //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnWaCAfSN08VMtSjYBj0QKSfHk4-fjJZCOxgHLPuBSAw&s")
              //       : Image.network(user.imageUrl!),
              // ),
              InkWell(
                onTap: () {
                  _showBottomSheet();
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  padding: EdgeInsets.all(mq.height * .003),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          //container won't render the borderradius as it will paint its color over it
          //hence use something else other than container
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: mq.height * 0.008, bottom: mq.height * 0.03),
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * 0.005, horizontal: mq.width * 0.4),
                height: mq.height * 0.007,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(mq.width * 0.01)),
              ),
              SizedBox(height: mq.height * 0.01),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              const Text("Pick Profile Photo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              // SizedBox(width: mq.width * 0.02),
              //tooltip suggesting maximum file size 100KB
              // const Tooltip(
              //     message: "Maximum File Size is 100KB",
              //     child: Icon(Icons.info_rounded))
              // ],
              // ),
              SizedBox(height: mq.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick photo from gallery
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            // Pick an image.
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              //reducing image quality to 70, ranges from 0-100
                              imageQuality: 70,
                            );

                            //size in KB
                            // final fileBytes =
                            //     File(_image!).readAsBytesSync().lengthInBytes /
                            //         1024;
                            // int size in KB
                            // final int intFileBytes = fileBytes.toInt();
                            // print(
                            //     "===> File Size in kB : $intFileBytes KB, in MB :${(intFileBytes / 1048576)} MB");
                            if (image != null) {
                              setState(() {
                                _image = image.path;
                              });

                              if (context.mounted) {
                                accountServices.addProfilePicture(
                                    context: context,
                                    imagePicked: File(_image!));

                                // function here
                                // APIs.updateProfilePicture(File(_image!));

                                print(
                                    "\nImage path =====>${image.path} ---- Mimetype ====> ${image.mimeType}");

                                //hiding bottomsheet
                                Navigator.pop(context);
                                // showSnackBar(
                                //     context: context,
                                //     text: "Profile Picture updated successfully!");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              fixedSize:
                                  Size(mq.width * 0.25, mq.height * 0.15)),
                          child: Image.asset("assets/images/gallery.png")),
                      const Text("Gallery"),
                    ],
                  ),

                  //pick photo from camera
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            // Pick an image.
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera);

                            if (image != null) {
                              setState(() {
                                _image = image.path;
                              });

                              if (context.mounted) {
                                accountServices.addProfilePicture(
                                    context: context,
                                    imagePicked: File(_image!));

                                //hiding bottomSheet
                                Navigator.pop(context);
                              }
                              print("\n\n\n");
                              print("Image path =====>${image.path}");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              fixedSize:
                                  Size(mq.width * 0.25, mq.height * 0.15)),
                          child: Image.asset("assets/images/camera.png")),
                      const Text("Camera"),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}
