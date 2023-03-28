// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:foodapp/Pages/ProfilePage.dart';
import 'package:foodapp/Pages/tokenPage.dart';
import 'package:foodapp/Data/food.dart';
import 'package:foodapp/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/model/food.dart';
import 'package:foodapp/Widgets/foodCard.dart';
import 'package:foodapp/Constants/values.dart';


import '../Data/category.dart';
import '../provider/profile_provider.dart';
import '../storage.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Map profileData = {};
  Map category = {};
  int value = 1;

  void initState() {
    print("h");
    getData();
    getCategory();
    print('category ${category}');
  }

  Future<Map> getCategory() async {
    // Map newCat = {};
    print("hi");
    FoodCategory cat = FoodCategory();
    print("hii");
    category = await cat.getCategory();
    print("hiii");
    print(category);
    return category;
  }

  void getData() async {
    profileData = await context.read<Profile>().getProfile() as Map;
    print(profileData);
  }

  List menu = [];
  // Map menu = {};
  Food foodList = Food();

  Future<List> getMenu() async {
    Food foodList = Food();
    List menuResponse = await foodList.getMenu();

    menu = menuResponse.map((food) => FoodItem(id: food['_id'], name: food['foodName'], price: food['foodPrice'])).toList();

    return menu;
    // print(menu['menu'].length);
  }
  // Future<Map> getMenu() async {
  //   Food foodList = Food();
  //   menu = await foodList.getMenu();

  //   return menu;
  //   // print(menu['menu'].length);
  // }

  void logout() async {
    secureStorage store = secureStorage();
    await store.deleteToken();
    await store.deleteId();
    // print((await store.getToken())!+" token");
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.pushNamed(context, '/cart')
          },
          child: Icon(Icons.shopping_cart),
        ),
        // drawer: Drawer(
        //   child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: <Widget>[
        //         FractionallySizedBox(
        //           widthFactor: 1,
        //           heightFactor: 0.25,
        //           child: Padding(
        //             padding: const EdgeInsets.all(00),
        //             child: ElevatedButton(
        //               onPressed: () => {},
        //               child: const Text("Widget 1"),
        //             ),
        //           ),
        //         ),
        //         FractionallySizedBox(
        //           widthFactor: 1,
        //           heightFactor: 0.25,
        //           child: Padding(
        //             padding: const EdgeInsets.all(00),
        //             child: ElevatedButton(
        //               onPressed: () => {},
        //               child: const Text("Widget 1"),
        //             ),
        //           ),
        //         ),
        //         FractionallySizedBox(
        //           widthFactor: 1,
        //           heightFactor: 0.25,
        //           child: Padding(
        //             padding: const EdgeInsets.all(00),
        //             child: ElevatedButton(
        //               onPressed: () => {},
        //               child: const Text("Widget 1"),
        //             ),
        //           ),
        //         ),
        //       ]),
        // ),
        appBar: AppBar(
          title: const Text("BreakBite"),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                  child: Container(
                    height: 40,
                    width: 40,
                    // color: Colors.black,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/profile')},
                          // {Navigator.push(context, MaterialPageRoute(builder: builder))}
                    ),
                  ),
                )
              ],
            )
          ],
          // elevation: 0,
          // toolbarHeight: 200,
          // backgroundColor: Colors.amber,
          // title: const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20),child: Text("Wednesday offer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),),
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     // gradient: LinearGradient(colors: colors),
          //     // image: DecorationImage(image: NetworkImage("https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg"),alignment: Alignment.centerRight),
          //     image: DecorationImage(image: AssetImage('assets/dosa.png'),alignment: Alignment.centerRight,scale: 0.01),
          //   ),
          // ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: <Widget>[
              buildAppBar(),
              buildFoodFilter(),
              Divider(),
              buildFoodList(),
            ],
          ),
        ),
      );
    }


  Widget buildAppBar() {
    // int items = 0;
    // Provider.of<MyCart>(context).cartItems.forEach((cart) {
    //   items += cart.quantity;
    // });
    return Container(
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(left: 8),
                child: Text('MENU', style: headerStyle),
              ),
              Spacer(),
              // IconButton(icon: Icon(Icons.person), onPressed: viewProfile),
              // IconButton(
              //     icon: Icon(Icons.refresh),
              //     onPressed: () {
              //       // foodModels = fetchAllFoods();
              //       // setState(() {});
              //     }),
              // Stack(
              //   children: <Widget>[
              //     // IconButton(icon: Icon(Icons.shopping_cart), onPressed: showCart),
              //     Positioned(
              //       right: 0,
              //       child: Container(
              //         alignment: Alignment.center,
              //         padding: EdgeInsets.all(4),
              //         decoration: BoxDecoration(shape: BoxShape.circle, color: mainColor),
              //         // child: Text(
              //         //   '$items',
              //         //   style: TextStyle(fontSize: 12, color: Colors.black),
              //         // ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }


Widget buildFoodFilter() {
  return Container(
    height: 55,
    //color: Colors.red,
    child: FutureBuilder(
      future: getCategory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } 
        else {
          return ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: List.generate(category['categories'].length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  selectedColor: Color.fromRGBO(255, 204, 0, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  labelStyle: TextStyle(color: value == index ? Colors.white : Colors.black),
                  label: Text(category['categories'][index]["categoryName"].toString().split('.').last),
                  selected: value == index,
                  onSelected: (selected) {
                    setState(() {
                      value = index;
                    });
                  },
                ),
              );
            }),
          );
        }
      },
    ),
  );
}



Widget buildFoodList() {
  return Expanded(
    child: FutureBuilder(
      future: getMenu(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            childAspectRatio: 0.85,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: 2,
            physics: BouncingScrollPhysics(),
            children: menu.map((food) {
              return FoodCard(food);
            }).toList(),
            // children: menu.map((food) {
            //   return FoodCard(FoodItem(id:food['_id'], name: food['foodName'], price: food['foodPrice']));
            // }),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return Center(child: CircularProgressIndicator());
      },
    ),
  );
}



}


