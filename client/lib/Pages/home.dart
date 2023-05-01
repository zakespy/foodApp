import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:foodapp/Pages/homeView.dart';
import 'package:foodapp/Pages/cartPage.dart';
import 'package:foodapp/Pages/ProfilePage.dart';
import 'package:foodapp/Pages/myOrdersPage.dart';
import 'package:foodapp/Data/category.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/provider/menu_provider.dart';

import '../provider/profile_provider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  Map profileData = {};
  // Map category = {};
  
  void getData() async {
    profileData = await context.read<Profile>().getProfile() as Map;
    // await Provider.of<MenuProvider>(context, listen: false).setMenu();
    
    print(profileData);
  }

  // Future<Map> getCategory() async {
  //   // Map newCat = {};
  //   // print("hi");
  //   FoodCategory cat = FoodCategory();
  //   // print("hii");
  //   category = await cat.getCategory();
  //   // print("hiii");
  //   // print(category);
  //   return category;
  // }

  final screen = [
    homeView(),
    CartPage(),
    ProfilePage({}),
    ordersPage(),
  ];

  @override
  void initState() {
    getData();
    // getCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(1111111);
    // Provider.of<MenuProvider>(context).setMenu();
    print(1111111);
    final items = [
      Icon(Icons.home),
      Icon(Icons.shopping_cart),
      Icon(Icons.person),
      Icon(Icons.shopping_cart),
    ];
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color(0xFFFF9505),
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: screen[index],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(color: Colors.white)
            ),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: Color.fromARGB(255, 110, 110, 110),
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Color(0xFFFF9505),      /// 60.0
              height: MediaQuery.of(context).size.height/11.39,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 400),
              index: index,
              items: items,
              onTap: (index) => setState(() => this.index = index),
            ),
          ),
        ),
      ),
    );
  }
}

// class SizeConfig {
//   static MediaQueryData? _mediaQueryData;
//   static double? screenWidth;
//   static double? screenHeight;

//   void init(BuildContext context){
//     _mediaQueryData = MediaQuery.of(context);
//     screenWidth = _mediaQueryData!.size.width;        /// 683
//     screenHeight = _mediaQueryData!.size.height;      /// 411
//   }
// }