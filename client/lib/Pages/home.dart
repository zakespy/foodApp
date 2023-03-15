// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:foodapp/Pages/ProfilePage.dart';
import 'package:foodapp/Data/food.dart';
import 'package:foodapp/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/Pages/tokenPage.dart';

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

  void initState() {
    print("h");
    getData();
    print('category ${category}');
  }

  Future<Map> getCategory() async {
    // Map newCat = {};
    print("hi");
    FoodCategory cat = FoodCategory();
    print("hii");
    category = await cat.getCategory();
    print("hiii");
    return category;
    // print(category['categories']);
  }

  void getData() async {
    profileData = await context.read<Profile>().getProfile() as Map;
    print(profileData);
  }

  Map menu = {};
  Food foodList = Food();

  Future<Map> getMenu() async {
    Food foodList = Food();
    menu = await foodList.getMenu();
    return menu;
    // print(menu['menu'].length);
  }

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
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          child: Icon(Icons.shopping_cart),
        ),
        drawer: Drawer(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(00),
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text("Widget 1"),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(00),
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text("Widget 1"),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(00),
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text("Widget 1"),
                    ),
                  ),
                ),
              ]),
        ),
        appBar: AppBar(
          title: const Text("appbar"),
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
                      icon: const Icon(Icons.person_2_rounded),
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/profile')},
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
        body: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Container(
              //     height: 200,
              //     width: 400,
              //     color: Colors.amber,
              //     child: Center(
              //       child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: const <Widget>[
              //             SizedBox(width: 5),
              //             Padding(
              //               padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              //               child: Text(
              //                 "Wednesday offer",
              //                 style: TextStyle(
              //                     fontSize: 20, fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(width: 25),
              //             Image(
              //               image: AssetImage("assets/dosa.png"),
              //               alignment: Alignment.center,
              //               height: 150,
              //               width: 150,
              //             )
              //           ]),
              //     ),
              //   ),
              // ),
              Container(
                height: 50,
                // color: Colors.blue,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     TextButton(
                //         onPressed: () => {},
                //         child: const Text(
                //           "Breakfast",
                //           style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 15,
                //               fontWeight: FontWeight.w500),
                //         )),
                //     TextButton(
                //         onPressed: () => {},
                //         child: const Text(
                //           "Lunch",
                //           style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 15,
                //               fontWeight: FontWeight.w500),
                //         )),
                //     TextButton(
                //         onPressed: () => {},
                //         child: const Text(
                //           "Drinks",
                //           style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 15,
                //               fontWeight: FontWeight.w500),
                //         )),
                //   ],
                // )),

                child: FutureBuilder(
                  future: getCategory(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                        color: Colors.amber,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: category['categories'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryCard(
                                  title: category['categories'][index]
                                      ["categoryName"]);
                            }),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                    height: 750,
                    width: 350,
                    color: Color.fromRGBO(239, 154, 154, 1),
                    child: FutureBuilder(
                        future: getMenu(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Container(
                                child: ListView.builder(
                                    itemCount: menu['menu'].length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: 250,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          30, 10, 30, 10),
                                                      child: Container(
                                                        height: 70,
                                                        width: 70,
                                                        child:
                                                            const Text("Image"),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 70,
                                                      width: 70,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Title(
                                                              color:
                                                                  Colors.black,
                                                              child: Text(
                                                                '${menu['menu'][index]['foodName']}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )),
                                                          Title(
                                                              color:
                                                                  Colors.black,
                                                              child: Text(
                                                                '${menu['menu'][index]['foodType']}',
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            // IconButton(onPressed: ()=>{}, icon: Icon(Icons.shopping_cart,color: Colors.black54,))
                                            Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: TextButton(
                                                    // onPressed: () => {print("Hii")},
                                                    // onPressed: () => {print(menu['menu'][index])},
                                                    onPressed: () => context
                                                        .read<Cart>()
                                                        .addToCart(menu['menu']
                                                            [index]),
                                                    child: const Text(
                                                      "Add",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color.fromARGB(
                                                              255,
                                                              53,
                                                              123,
                                                              157)),
                                                    )))
                                          ],
                                        ),
                                      );
                                      // return Text(
                                      //     '${menu['menu'][index]['foodName']}');
                                    }));
                          }
                        })

                    // child: Column(
                    //   children: <Widget>[
                    //     Center(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Container(
                    //           height: 60,
                    //           width: 370,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    ),
              ),
            ],
          ),
        )
        //   Container(
        //   child: Center(
        //     child: ElevatedButton(
        //       child: Text("Logout"),
        //       onPressed: () {
        //         logout();
        //       },
        //     ),
        //   ),
        // ),
        );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  const CategoryCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // return Text('${title}');
    return TextButton(onPressed: () {}, child: Text('${title}'));
  }
}


// Container(
//       child: Center(
//         child: ElevatedButton(
//           child: Text("Logout"),
//           onPressed: () {
//             logout();
//           },
//         ),
//       ),
//     );
