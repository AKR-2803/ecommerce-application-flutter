import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/common/widgets/loader.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/common/widgets/custom_button.dart';
import 'package:ecommerce_major_project/common/widgets/custom_textfield.dart';
import 'package:ecommerce_major_project/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const String routeName = '/add-product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController brandNameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();

/*

Brand name/manufacturer
Discount %
Color

*/

  String category = "Mobiles";
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  bool showLoader = false;

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      setState(() {
        showLoader = true;
      });

      print("\n\nSHOW LOADER value before: ==> $showLoader");
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        brandName: brandNameController.text,
        price: num.parse(priceController.text) + 0.0,
        //MOST IMPORTANT to ensure type casting in DART!
        quantity: int.parse(quantityController.text),
        category: category,
        images: images,
      );
      // setState(() {
      //   showLoader = false;
      // });
      print("\n\nSHOW LOADER value after: ==> $showLoader");
    }
    // print(
    //     " user type : \n\n${Provider.of<UserProvider>(context, listen: false).user.email}");
  }

  void selectImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    brandNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVariables.getAdminAppBar(
          context: context, title: "Add a product"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * .03),
                child: Column(
                  children: [
                    SizedBox(height: mq.height * .02),
                    images.isNotEmpty
                        ?
                        // images picked are not null
                        CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                builder: (context) => Image.file(i,
                                    fit: BoxFit.cover, height: mq.width * .48),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              viewportFraction: 1,
                              height: mq.width * .48,
                            ),
                          )
                        :
                        // no images picked
                        GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(mq.width * .025),
                              dashPattern: const [10, 4.5],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: mq.height * .18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.folder_open, size: 40),
                                    SizedBox(height: mq.height * .02),
                                    const Text("Select Product Images",
                                        style:
                                            TextStyle(color: Colors.black26)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: mq.height * .03),
                    CustomTextField(
                        controller: productNameController,
                        hintText: "Product Name"),
                    SizedBox(height: mq.height * .01),
                    CustomTextField(
                        controller: descriptionController,
                        hintText: "Description",
                        maxLines: 7),
                    SizedBox(height: mq.height * .01),
                    CustomTextField(
                        controller: brandNameController,
                        hintText: "Brand name"),
                    SizedBox(height: mq.height * .01),
                    CustomTextField(
                        controller: priceController, hintText: "Price"),
                    SizedBox(height: mq.height * .01),
                    CustomTextField(
                        controller: quantityController, hintText: "Quantity"),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: mq.width * .14)
                                .copyWith(bottom: 0),
                        child: DropdownButton(
                          focusColor: Colors.pinkAccent,
                          alignment: Alignment.centerLeft,
                          dropdownColor: Color.fromARGB(255, 202, 183, 255),
                          borderRadius: BorderRadius.circular(10),
                          value: category,
                          onChanged: (String? newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: productCategories.map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.height * .01),
                    CustomButton(
                      text: "Sell",
                      onTap: sellProduct,
                    ),
                  ],
                ),
              ),
            ),
          ),
          showLoader ? const Loader() : const SizedBox.shrink()
        ],
      ),
    );
  }
}


/* 




// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// import 'package:ecommerce_major_project/main.dart';
// import 'package:ecommerce_major_project/constants/utils.dart';
// import 'package:ecommerce_major_project/common/widgets/loader.dart';
// import 'package:ecommerce_major_project/constants/global_variables.dart';
// import 'package:ecommerce_major_project/common/widgets/custom_button.dart';
// import 'package:ecommerce_major_project/common/widgets/custom_textfield.dart';
// import 'package:ecommerce_major_project/features/admin/services/admin_services.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});
//   static const String routeName = '/add-product';

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final TextEditingController productNameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final AdminServices adminServices = AdminServices();

//   String category = "Mobiles";
//   List<File> images = [];
//   final _addProductFormKey = GlobalKey<FormState>();
//   bool showLoader = false;

//   List<String> productCategories = [
//     "Mobiles",
//     "Essentials",
//     "Appliances",
//     "Books",
//     "Fashion"
//   ];

//   void sellProduct() {
//     if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
//       setState(() {
//         showLoader = true;
//       });

//       print("\n\nSHOW LOADER value before: ==> $showLoader");
//       adminServices.sellProduct(
//         context: context,
//         name: productNameController.text,
//         description: descriptionController.text,
//         price: num.parse(priceController.text) + 0.0,
//         //MOST IMPORTANT to ensure type casting in DART!
//         quantity: int.parse(quantityController.text),
//         category: category,
//         images: images,
//       );
//       // setState(() {
//       //   showLoader = false;
//       // });
//       print("\n\nSHOW LOADER value after: ==> $showLoader");
//     }
//     // print(
//     //     " user type : \n\n${Provider.of<UserProvider>(context, listen: false).user.email}");
//   }

//   void selectImages() async {
//     var result = await pickImages();
//     setState(() {
//       images = result;
//     });
//   }

//   @override
//   void dispose() {
//     productNameController.dispose();
//     descriptionController.dispose();
//     priceController.dispose();
//     quantityController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(mq.height * 0.06),
//         child: AppBar(
//           flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                   gradient: GlobalVariables.appBarGradient)),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Image.asset(
//                   "assets/images/amazon_in.png",
//                   width: mq.width * 0.3,
//                   height: mq.height * 0.055,
//                   color: Colors.black,
//                 ),
//               ),
//               const Text("Admin",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                     color: Colors.black,
//                     fontStyle: FontStyle.normal,
//                   )),
//               // Text(
//               //   "${(mq.height * 1).toInt()}",
//               //   style: TextStyle(fontSize: 18),
//               // ),
//               // Text(
//               //   "${(mq.width).toInt()}",
//               //   style: TextStyle(fontSize: 18),
//               // )
//             ],
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Form(
//               key: _addProductFormKey,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: mq.width * .03),
//                 child: Column(
//                   children: [
//                     SizedBox(height: mq.height * .02),
//                     images.isNotEmpty
//                         ?
//                         // images picked are not null
//                         CarouselSlider(
//                             items: images.map((i) {
//                               return Builder(
//                                 builder: (context) => Image.file(i,
//                                     fit: BoxFit.cover, height: mq.width * .48),
//                               );
//                             }).toList(),
//                             options: CarouselOptions(
//                               autoPlay: true,
//                               autoPlayInterval: const Duration(seconds: 2),
//                               viewportFraction: 1,
//                               height: mq.width * .48,
//                             ),
//                           )
//                         :
//                         // no images picked
//                         GestureDetector(
//                             onTap: selectImages,
//                             child: DottedBorder(
//                               borderType: BorderType.RRect,
//                               radius: Radius.circular(mq.width * .025),
//                               dashPattern: const [10, 4.5],
//                               strokeCap: StrokeCap.round,
//                               child: Container(
//                                 width: double.infinity,
//                                 height: mq.height * .18,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(Icons.folder_open, size: 40),
//                                     SizedBox(height: mq.height * .02),
//                                     const Text("Select Product Images",
//                                         style:
//                                             TextStyle(color: Colors.black26)),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                     SizedBox(height: mq.height * .03),
//                     CustomTextField(
//                         controller: productNameController,
//                         hintText: "Product Name"),
//                     SizedBox(height: mq.height * .01),
//                     CustomTextField(
//                         controller: descriptionController,
//                         hintText: "Description",
//                         maxLines: 7),
//                     SizedBox(height: mq.height * .01),
//                     CustomTextField(
//                         controller: priceController, hintText: "Price"),
//                     SizedBox(height: mq.height * .01),
//                     CustomTextField(
//                         controller: quantityController, hintText: "Quantity"),
//                     SizedBox(
//                       width: double.infinity,
//                       child: DropdownButton(
//                         value: category,
//                         onChanged: (String? newVal) {
//                           setState(() {
//                             category = newVal!;
//                           });
//                         },
//                         icon: const Icon(Icons.keyboard_arrow_down_rounded),
//                         items: productCategories.map((String item) {
//                           return DropdownMenuItem(
//                               value: item, child: Text(item));
//                         }).toList(),
//                       ),
//                     ),
//                     SizedBox(height: mq.height * .01),
//                     CustomButton(
//                       text: "Sell",
//                       onTap: sellProduct,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           showLoader ? const Loader() : const SizedBox.shrink()
//         ],
//       ),
//     );
//   }
// }

*/

