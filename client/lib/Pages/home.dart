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
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 200,
        backgroundColor: Colors.amber,
        title: Padding(padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),child: Text("Wednesday offer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(colors: colors),
            // image: DecorationImage(image: NetworkImage("https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg"),alignment: Alignment.centerRight),
            image: DecorationImage(image: AssetImage('assets/dosa.png'),alignment: Alignment.centerRight,scale: 0.01),
          ),
        ),
      ),
      body:Container(
      child: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            logout();
          },
        ),
      ),
    ),
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
