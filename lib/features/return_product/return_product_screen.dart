import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/common/widgets/custom_textfield.dart';

class ReturnProductScreen extends StatefulWidget {
  const ReturnProductScreen({super.key});

  @override
  State<ReturnProductScreen> createState() => _ReturnProductScreenState();
}

class _ReturnProductScreenState extends State<ReturnProductScreen> {
  final _returnProuctFormKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  List<File> images = [];
  bool showLoader = false;

  void selectImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: GlobalVariables.getAppBar(
        //     title: "Return Product",
        //     context: context,
        //     wantActions: false,
        //     onClickSearchNavigateTo: MySearchScreen()),
        body: SingleChildScrollView(
      child: Form(
        key: _returnProuctFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: mq.height * .01),
              const Text("Why do want to return the proudct?",
                  style: TextStyle(fontSize: 18)),
              Text(
                "We deeply regret the inconvenience caused\nPlease take a minute to fill this feedback form",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
              SizedBox(height: mq.height * .05),
              images.isNotEmpty
                  ?
                  // images picked are not null
                  CarouselSlider(
                      items: images.map((i) {
                        return Builder(
                          builder: (context) => Image.file(
                            i,
                            fit: BoxFit.cover,
                            height: mq.width * .48,
                          ),
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
                          height: mq.height * .1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.folder_open, size: 40),
                              SizedBox(height: mq.height * .02),
                              const Text("Upload images",
                                  style: TextStyle(color: Colors.black26)),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: mq.height * .03),
              CustomTextField(
                controller: descriptionController,
                hintText: "Tell us what went wrong",
                maxLines: 4,
              ),
              SizedBox(height: mq.height * .03),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      // alignment: Alignment.center,
                      backgroundColor: Color.fromARGB(255, 255, 88, 88)),
                  child: const Text(
                    "Return Product",
                    style: TextStyle(color: Colors.white),
                  )),
              // SizedBox(height: mq.height * .01),
              // CustomTextField(
              //     controller: brandNameController, hintText: "Brand name"),
              // SizedBox(height: mq.height * .01),
              // CustomTextField(
              //     controller: priceController, hintText: "Price"),
              // SizedBox(height: mq.height * .01),
              // CustomTextField(
              //     controller: quantityController, hintText: "Quantity"),
              // SizedBox(
              //   width: double.infinity,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: mq.width * .14)
              //         .copyWith(bottom: 0),
              //     child: DropdownButton(
              //       focusColor: Colors.pinkAccent,
              //       alignment: Alignment.centerLeft,
              //       dropdownColor: Color.fromARGB(255, 202, 183, 255),
              //       borderRadius: BorderRadius.circular(10),
              //       value: category,
              //       onChanged: (String? newVal) {
              //         setState(() {
              //           category = newVal!;
              //         });
              //       },
              //       icon: const Icon(Icons.keyboard_arrow_down_rounded),
              //       items: productCategories.map((String item) {
              //         return DropdownMenuItem(
              //             value: item, child: Text(item));
              //       }).toList(),
              //     ),
              //   ),
              // ),
              // SizedBox(height: mq.height * .01),
              // CustomButton(
              //   text: "Sell",
              //   onTap: sellProduct,
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}
