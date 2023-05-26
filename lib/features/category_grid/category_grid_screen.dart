import 'package:flutter/material.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/search_delegate/my_search_screen.dart';
import 'package:ecommerce_major_project/features/home/screens/category_deals_screen.dart';

class CategoryGridScreen extends StatelessWidget {
  CategoryGridScreen({super.key});

  List<Map<String, String>> myCategoryList = GlobalVariables.categoryImages2;

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "All Categories",
          onClickSearchNavigateTo: MySearchScreen()),
      body: GridView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(mq.height * .01),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.4,
            crossAxisSpacing: mq.width * .03,
            mainAxisSpacing: mq.width * .015,
            crossAxisCount: 2),
        itemCount: myCategoryList.length,
        itemBuilder: (context, index) {
          // print("\n\nimage path is : ${myCategoryList[index]['title']}");
          final categoryTitle = myCategoryList[index]['title'];
          final categoryImage = myCategoryList[index]['image'];

          return InkWell(
            onTap: () {
              navigateToCategoryPage(context, productCategories[index]);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 80,
                    child: Image.asset(categoryImage!),
                  ),
                  SizedBox(height: mq.height * .01),
                  Text(
                    categoryTitle!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
