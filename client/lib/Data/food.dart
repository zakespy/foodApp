import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../storage.dart';

class Food {
  Future<List> getMenu() async {
    try {
      String path = 'http://10.0.2.2:8000/api/food/allFood';
      // String path = 'http://10.0.2.2:8000/api/food/allFood';
      Response response = await http.get(Uri.parse(path), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      // print(response.body);
      Map res = jsonDecode(response.body);
      // print(res['menu']);
      return res['menu'];
    } catch (err) {
      return Future.error(err);
    }
  }
}
