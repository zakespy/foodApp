
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Pages/home.dart';
// import 'Pages/login.dart';
// import 'Pages/signup.dart';
import '../storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  CheckToken to = CheckToken();
  Future<bool> tokenValue = to.verifyToken();
  if(await tokenValue){
    runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => home(),
      // '/signup': (context) => SignUp(),
      // '/login': (context)=> login(),
      // '/home': (context) => home()
    },
  ));
  }else{
    runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // '/': (context) => login(),
      // '/signup': (context) => SignUp(),
      '/home': (context) => home(),
      // '/login':(context) => login() 
    },
  ));
  }
  
}

class CheckToken {
  final secureStorage store = secureStorage();

  Future<bool> verifyToken() async {
    String? token = await store.getToken();
    if (token!.isEmpty || token == '') {
      return false;
    } else {
      return true;
    }
  }
}




