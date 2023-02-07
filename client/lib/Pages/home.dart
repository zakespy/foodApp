// import 'dart:html';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import '../storage.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
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
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Padding(
            padding:  const EdgeInsets.all(10),
            child: ElevatedButton(onPressed: ()=>{},
            child: Text("Widget 1"),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(10),
            child: ElevatedButton(onPressed: ()=>{},
            child: Text("Widget 2"),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(10),
            child: ElevatedButton(onPressed: ()=>{},
            child: Text("Widget 3"),
            ),
          ),
        
        ]),
      ),
      appBar: AppBar(
        title: Text("appbar"),
        actions: [Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5,5,10,5),
              child: Container(
                height: 40,
                width: 40,
                // color: Colors.black,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                // child: IconButton(icon: Icon(Icons.person_2_rounded),onPressed: ()=>{},),
              ),
            )
          ],
        )],
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
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 200,
              width: 400,
              color: Colors.amber,
              child: Center(
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                  SizedBox(width:5),
                  Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20),child: Text("Wednesday offer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),),
                  SizedBox(width: 25),
                  Image(image: AssetImage("assets/dosa.png"),alignment: Alignment.center,height: 150,width: 150,)
                ]),
              ),
            ),
          ),
          Container(
            height: 50,
            // color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              TextButton(onPressed: ()=>{}, child: const Text("Menu",style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),)),
              TextButton(onPressed: ()=>{}, child: const Text("Today's Special",style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),)),
              TextButton(onPressed: ()=>{}, child: const Text("Offer",style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),)),
            ],)
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,10),
            child: Container(
              height: 650,
              width: 400,
              color: Colors.red[200],
              child: Column(children: <Widget>[

              ],),
            ),
          ),
        ],),
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
