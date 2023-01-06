import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Customer {
  String url = 'http://10.0.2.2:8000/api/';
  String emailID = '';
  String password = '';
  String name = '';
  String phoneNo = '';

  Future<Map> register(
      String emailId, String password, String name, String phoneNo) async {
    try {
      String path = 'http://10.0.2.2:8000/api/signup';
      Response response = await http.post(Uri.parse(path), body: {
        emailId: emailID,
        password: password,
        name: name,
        phoneNo: phoneNo
      });
      print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      return Future.error(err);
    }
  }

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