import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FoodCategory {
  Future<Map> getCategory() async {
    try {
      String path = 'http://localhost:8000/api/category/getAllCategory';
      // String path = 'http://localhost:8000/api/category/getAllCategory';
      Response response = await http.get(Uri.parse(path), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      print(response.body);
      Map res = jsonDecode(response.body);
      // print(res);
      return res;
    } catch (err) {
      return Future.error(err);
    }
  }
}
