import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final int _tabLength = 5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLength, vsync: this);
  }

/*
Column  children [0]  ->  [ DefaultTabController -> child : SizedBox(TabBar) [to avoid render overflow]  ->  tabs : [icons or widgets of menu] ]  ->    


        children[1]   ->  [ NotificationListener with onNotification method ]  ->  TabBarView  ->  children : [contents of the respective tabs]
*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 500,
          width: 400,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              DefaultTabController(
                length: _tabLength,
                child: SizedBox(
                  width: 250,
                  child: TabBar(controller: _tabController, tabs: [
                    Icon(Icons.settings, color: Colors.black),
                    Icon(
                      Icons.list_alt,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.face,
                      color: Colors.pink,
                    ),
                    Icon(
                      Icons.dangerous,
                      color: Colors.pink,
                    ),
                    Icon(
                      Icons.abc_outlined,
                      color: Colors.pink,
                    ),
                  ]),
                ),
              ),
              NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    _onTabChanged();
                  }
                  return false;
                },
                child: SizedBox(
                  height: 200,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Image.network(
                        "https://rukminim1.flixcart.com/image/416/416/xif0q/mobile/h/e/g/-original-imagh7g8k7ttcdkc.jpeg?q=70",
                        height: 35,
                        // fit: BoxFit.fitHeight,
                      ),
                      Image.network(
                        "https://rukminim1.flixcart.com/image/416/416/ktketu80/mobile/6/n/d/iphone-13-mlpg3hn-a-apple-original-imag6vpyghayhhrh.jpeg?q=70",
                        height: 35,
                        // fit: BoxFit.fitHeight,
                      ),
                      Image.network(
                        "https://rukminim1.flixcart.com/image/416/416/xif0q/mobile/h/e/g/-original-imagh7g8k7ttcdkc.jpeg?q=70",
                        height: 35,
                        // fit: BoxFit.fitHeight,
                      ),
                      Image.network(
                        "https://rukminim1.flixcart.com/image/416/416/xif0q/mobile/w/k/h/-original-imagh2gwxu57j4fn.jpeg?q=70",
                        height: 35,
                        // fit: BoxFit.fitHeight,
                      ),
                      Image.network(
                        "https://rukminim1.flixcart.com/image/416/416/xif0q/mobile/h/e/g/-original-imagh7g8k7ttcdkc.jpeg?q=70",
                        height: 35,
                        // fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTabChanged() {
    switch (_tabController.index) {
      case 0:
        // handle 0 position
        break;
      case 1:
        // handle 1 position
        break;
      case 2:
        // handle 1 position
        break;
      case 3:
        // handle 1 position
        break;
      case 4:
        // handle 1 position
        break;
    }
  }
}
