import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/model/orders.dart';
import 'package:foodapp/model/food.dart';

class OrdersProvider with ChangeNotifier {
  
  MyOrders myOrdersList = MyOrders();

  MyOrders get orders_data => myOrdersList;
  // int get orders_data_length => myOrdersList.getLength();

  void addToOrders( List orderList, int token ) {
    List<Map> order_list = [];

    for (Map item in orderList) {
      Map food = { 'foodName': item['foodName'], 'foodPrice': item['foodPrice'], 'quantity': item['quantity'] };

      order_list.add(food);
    print(order_list);
    }
    OrderItems orderDetails = OrderItems(order: order_list, token: token);
    print(orderDetails.order);

    myOrdersList.addOrder( orderDetails );
    print('123');
    print(myOrdersList.toJson());
    print('123');
  }

  void removeFormOrdersList( String token ) {
    myOrdersList.removeOrder(token);
  }

}