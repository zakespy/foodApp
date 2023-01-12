// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:foodapp/Pages/home.dart';
import 'Pages/login.dart';
import 'Pages/signup.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => login(),
      '/signup':(context) => SignUp(),
      '/home' :(context) => home()
    },
  ));
}
