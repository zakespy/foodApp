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
    print(item.order);
    print(allOrders[0].order);
  }

  void removeOrder( String token ) {
    allOrders.removeWhere((element) => element.token == token );
  }

  void changeStatusByToken( String token ) {
    int index = 0;

    for(int i = 0; i < allOrders.length; i++){
      if( allOrders[i].token == token ) allOrders[i].changeStatus();
    }

  }

  Map toJson() {
    List jsonList = [];

    jsonList = allOrders.map((e) => {
        e.toJson()
    }).toList();
print(jsonList);
    return {
      "allOrders": jsonList
    };
  }

}


class OrderItems {
  List<Map> order;
  int token;
  bool status;

  OrderItems({ required this.order, required this.token, required this.status});

  Map toJson() {
    List<Map> jsonList = [];
    
    jsonList = order.map((e) => {
        "foodName": e['foodName'], 
        "foodPrice": e['foodPrice'], 
        "quantity": e['quantity']     
    }).toList();

    return{
      "order": jsonList,
      "token": token,
      "status": status
    };
  }

  int getLength(){
    return order.length;
  }

  int getPrice(){
    int price=0;

    order.map((e) => {
      price += e['foodPrice']*e['quantity'] as int,
      print(price),
      });

    return price;
  }

  void changeStatus () {
    status = true;
  }

}