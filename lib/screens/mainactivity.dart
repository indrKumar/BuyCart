import 'package:flutter/material.dart';

import '../utils/apis.dart';
import '../widgets/common/itemcount.dart';
import 'all_bottom_navigation/bag_checkout/bag_page.dart';
import 'all_bottom_navigation/categories/categories_page.dart';
import 'all_bottom_navigation/favorite_page.dart';
import 'all_bottom_navigation/home/home_page.dart';
import 'all_bottom_navigation/profile_page.dart';

class MainActivity_page extends StatefulWidget {
  static String id = "MainActivity";
  MainActivity_page({super.key});

  @override
  State<MainActivity_page> createState() => _MainActivity_pageState();
}

class _MainActivity_pageState extends State<MainActivity_page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServisces().cartList().then((value) {
      //b
      setState(() {
        count = value["data"]["cartcount"];
        print(count);
      });
    });
  }

  String count = "";
  int _currentIndex = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final Tab = [
    Home_page(),
    const Categories_page(),
    const BagePage(),
    Favorite_page(),
    Profile_page()
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      ImageIcon(
        AssetImage("assets/home (1).png"),
        size: 23,
      ),
      ImageIcon(
        AssetImage("assets/category.png"),
        size: 23,
      ),
      ItemBadgeIcon(count: count.toString()),
      Icon(
        Icons.favorite_border,
        size: 23,
      ),
      ImageIcon(
        AssetImage("assets/profile.png"),
        size: 23,
      ),
    ];

    return Scaffold(
      body: Tab[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(fontSize: 10),
        items: [
          BottomNavigationBarItem(icon: items[0], label: "HOME"),
          BottomNavigationBarItem(icon: items[1], label: "CATEGORIES"),
          BottomNavigationBarItem(icon: items[2], label: "BAG"),
          BottomNavigationBarItem(icon: items[3], label: "FAVORITES"),
          BottomNavigationBarItem(icon: items[4], label: "PROFILE"),
        ],
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
      ),
    );
  }
}
