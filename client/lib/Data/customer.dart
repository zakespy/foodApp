import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../storage.dart';

class Customer {
  String url = 'http://localhost:8000/api/';
  String emailID = '';
  String password = '';
  String name = '';
  String phoneNo = '';

  Future<Map> register(
      // String emailId, String password, String name, String phoneNo
      Map user) async {
    try {
      print(user['emailId']);
      // Map<String, String> jsonMap = {};
      // String body = jsonEncode(jsonMap);
      // String path = 'http://localhost:8000/api/signup';
      String path = 'http://localhost:8000/api/signup';
      Response response = await http.post(Uri.parse(path),
          body: jsonEncode({
            'emailId': user['emailId'],
            'password': user['password'],
            'name': user['name'],
            'phoneNo': user['phoneNo']
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      // print(response.body);
      Map res = jsonDecode(response.body);

      return res;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<Map?> login(Map user) async {
    // String path = 'http://localhost:8000/api/login';
    String path = 'http://localhost:8000/api/login';
    Response response = await http.post(Uri.parse(path),
        body: jsonEncode(
            {'emailId': user['emailId'], 'password': user['password']}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    // print(response.body);
    Map res = jsonDecode(response.body);
    if (res['status'] == true) {
      print(res);
      final secureStorage _secureStorage = secureStorage();
      Map USER = res['user'];
      _secureStorage.setId(USER['_id']);
      _secureStorage.setToken(USER['token']);
      return res;
    } else {
      return null;
    }
  }

  Future<List> getAllCustomer() async {
    try {
      String path = 'http://localhost:8000/api/allCustomer';
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

  Future<Map> getProfile(String id) async {
    try {
      // print("inside data file"+id);
      String path = 'http://localhost:8000/api/profile';
      Response response = await http
          .post(Uri.parse(path), body: jsonEncode({'id': id}), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        // print(response.body);
        return jsonDecode(response.body);
      } else {
        return Future.error("Server error");
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}
