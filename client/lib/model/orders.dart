import 'dart:convert';

import 'package:foodapp/model/food.dart';

class MyOrders  {
  
  List<OrderItems> allOrders = []; 
  

  // MyOrders();

  // int getLength() {
  //   return allOrders.length;
  // }

  void addOrder( OrderItems item ) {
    print(allOrders);
    allOrders.add(item);
    print(item.toJson());
    print(allOrders[0].toJson());
  }

  void removeOrder( String token ) {
    allOrders.removeWhere((element) => element.token == token );
  }

  Map toJson() {
    List<Map> jsonList = [];

    allOrders.map((e) => {
      jsonList.add(
        e.toJson()
      )
    });

    return {
      "allOrders": jsonList
    };
  }

}


class OrderItems {
  List<Map> order;
  int token;

  OrderItems({ required this.order, required this.token });

  Map toJson() {
    List<Map> jsonList = [];
    
    order.map((e) => {
      jsonList.add({
        "foodName": e['foodName'], 
        "foodPrice": e['foodPrice'], 
        "quantity": e['quantity']
      })
    });

    return{
      "order": jsonList,
      "token": token
    };
  }

}