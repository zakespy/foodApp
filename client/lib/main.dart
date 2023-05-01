import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Pages/home.dart';
import 'package:foodapp/provider/cart_provider.dart';
import 'package:foodapp/provider/menu_provider.dart';
import 'package:foodapp/provider/token_provider.dart';
import 'package:foodapp/Pages/cartPage.dart';
import 'package:foodapp/provider/profile_provider.dart';
import 'package:foodapp/provider/my_orders_provider.dart';
import 'package:provider/provider.dart';
import 'Pages/login.dart';
import 'package:foodapp/Pages/ProfilePage.dart';
import 'Pages/signup.dart';
import '../storage.dart';
import 'package:foodapp/Pages/tokenPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CheckToken to = CheckToken();
  Future<bool> tokenValue = to.verifyToken();
  if (await tokenValue) {
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Cart(items: [])),
          ChangeNotifierProvider(create: (_) => Profile(data: {})),
          ChangeNotifierProvider(create: (_) => OrdersProvider()),
          ChangeNotifierProvider(create: (_) => Token(tokenList: [])),
          ChangeNotifierProvider(create: (_) => MenuProvider(), lazy: false,),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => home(),
            '/signup': (context) => SignUp(),
            '/login': (context)=> login(),
            '/home': (context) => home(),
            '/profile':(context)=> ProfilePage({}),
            '/cart':(context)=> CartPage(),
            '/token':(context)=>TokenPage(tokenNumber: 0)
          },
        )));
  } else {
    runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Cart(items: [])),
            ChangeNotifierProvider(create: (_) => Profile(data: {})),
            ChangeNotifierProvider(create: (_) => Token(tokenList: [])),
          ],
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => login(),
              '/signup': (context) => SignUp(),
              '/home': (context) => home(),
              '/login':(context) => login(),
              '/profile':(context)=> ProfilePage({}),
              '/cart':(context)=> CartPage(),
              '/token':(context)=>TokenPage(tokenNumber: 0)
            },
          )),
    );
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
