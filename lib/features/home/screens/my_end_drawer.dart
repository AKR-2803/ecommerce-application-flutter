import 'package:ecommerce_major_project/models/user.dart';
import 'package:flutter/material.dart';

class MyEndDrawer extends StatefulWidget {
  User user;
  MyEndDrawer({super.key, required this.user});

  @override
  State<MyEndDrawer> createState() => _MyEndDrawerState();
}

class _MyEndDrawerState extends State<MyEndDrawer> {
  List<IconData> iconList = [
    Icons.home,
    Icons.explore,
    Icons.theater_comedy,
    Icons.bookmark,
    Icons.topic_rounded,
    Icons.contact_phone_rounded
  ];
  List<String> iconNames = [
    "Home",
    "Explore",
    "Theme",
    "Bookmarks",
    "Topics",
    "Contact Us"
  ];

  @override
  Widget build(BuildContext context) {
    final myUser = widget.user;
    return Drawer(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30),
      // ),

      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(249, 249, 249, 1),
                Color.fromRGBO(19, 19, 19, 1),
              ],
              // begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              /*
	                      About stops :  The stops list, if specified, must have the same length as colors.
                            It specifies fractions of the vector from start to end, between 0.0 and 1.0, for each color. 
	                      If it is null, a uniform distribution is assumed.
                      */
              stops: [0.85, 0.2]),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange[500]),

              //current logged in userName
              accountName: Text(myUser.name),
              //current logged in userEmail
              accountEmail: Text(myUser.email),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepOrange[900]),
                padding: EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                ),
              ),
            ),
            for (int i = 0; i < 6; i++)
              ListTile(
                leading: Icon(
                  iconList[i],
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  iconNames[i],
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            SizedBox(
              height: 130,
            ),
            SizedBox(
              width: 30,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(242, 102, 62, 1),
                  minimumSize: Size(40, 70),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LogOut",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.login_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
