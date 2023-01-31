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
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            logout();
          },
        ),
      ),
    );
  }
}
