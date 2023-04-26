import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart with ChangeNotifier {
  List<Map> items = [{}];

  Cart({required this.items});

  List get cart => items;
  int get cartLength => items.length;

  List getCart() {
    // notifyListeners();
    return cart;
  }

  // void addToCart(Map item) {
  //   int count = -1;
  //   for (int i = 0; i < items.length; i++) {
  //     if (items[i]['foodName'] == item['foodName']) {
  //       if (items[i]['quantity'] != null) {
  //         items[i]['quantity']++;
  //       } else {
  //         items[i].update('quantity', (value) => 1, ifAbsent: () => 1);
  //       }
  //       count++;
  //     }
  //   }
  //   if (count == -1) {
  //     items.add(item);
  //     items[items.length - 1]
  //         .update('quantity', (value) => 1, ifAbsent: () => 1);
  //   }
  //   print(items);
  //   notifyListeners();
  // }
  bool addToCart(Map item) {
    try {
      int count = -1;
      for (int i = 0; i < items.length; i++) {
        if (items[i]['foodName'] == item['foodName']) {
          if (items[i]['quantity'] != null) {
            items[i]['quantity']++;
          } else {
            items[i].update('quantity', (value) => 1, ifAbsent: () => 1);
          }
          count++;
        }
      }
      if (count == -1) {
        items.add(item);
        items[items.length - 1]
            .update('quantity', (value) => 1, ifAbsent: () => 1);
      }
      print(items);
      notifyListeners();
      return true;
    } 
    catch (e) {
      return false;
    }
  }

  void removeFromCart(Map item) {
    items.remove(item);
    notifyListeners();
  }

  void decreaseQuantity(Map item) {
    for (int i = 0; i < items.length; i++) {
      if (items[i]['foodName'] == item['foodName']) {
        if (items[i]['quantity'] != null && items[i]['quantity'] != 0) {
          items[i]['quantity']--;
        } else {
          items.remove(item);
        }
      }
    }
    notifyListeners();
  }

  void increaseQuantity(Map item) {
    for (int i = 0; i < items.length; i++) {
      if (items[i]['foodName'] == item['foodName']) {
        if (items[i]['quantity'] != null) {
          items[i]['quantity']++;
        } else {}
      }
    }
    notifyListeners();
  }

  // List emptyCart() {
  //   items.clear();

  //   notifyListeners();

  //   return items;
  // }
  void emptyCart() {
    items.clear();
    print(items);
    notifyListeners();
  }
}
