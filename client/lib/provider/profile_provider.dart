import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Data/customer.dart';

class Profile with ChangeNotifier {
  Map data = {};

  Profile({required this.data});

  Map get cart => data;
  int get cartLength => data.length;

  Map getCart() {
    notifyListeners();
    return data;
  }

  Future<Map> getProfile() async {
    Customer customer = Customer();
    const storage = FlutterSecureStorage();
    String? ID = await storage.read(key: 'id');
    print(ID);
    data = await customer.getProfile(ID!);
    print(data);
    notifyListeners();
    return data;
  }
}
