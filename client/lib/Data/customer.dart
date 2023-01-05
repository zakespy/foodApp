import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Customer {
  String url = 'http://localhost:8000/api/';
  String emailID = '';
  String password = '';

  Future<List> getAllCustomer() async {
    try {
      String path = 'http://10.0.2.2:8000/api/allCustomer';
      Response response = await http.get(Uri.parse(path));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server error");
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}
