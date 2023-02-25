import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart with ChangeNotifier {
  List<Map> items = [{}];

  Cart({required this.items});

  List get cart => items;
  int get cartLength => items.length;

  void addToCart(Map item) {
    int count = -1;
    for (int i = 0; i < items.length; i++) {
      if (items[i]['foodName'] == item['foodName']) {
        if (items[i]['quantity'] != null) {
          items[i]['quantity']++;
        } else {
          items[i].update('quantity', (value) => 1,ifAbsent: ()=>1);
        }
        count++;
      }
    }
    if (count == -1) {
      items.add(item);
      items[items.length-1].update('quantity', (value) => 1,ifAbsent: ()=>1);
    }
    notifyListeners();
  }

  void removeFromCart(List item) {
    item.remove(item);
    notifyListeners();
  }
}
