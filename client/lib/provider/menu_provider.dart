import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:foodapp/Data/food.dart';
import 'package:foodapp/model/food.dart';

class MenuProvider with ChangeNotifier {
  List fullMenu = [];

  MenuProvider(){
    setMenu();
  }

  void setMenu() async {
    Food foodApi = Food();
    // List responseMenu;
    fullMenu = await foodApi.getMenu();
    notifyListeners();
    // fullMenu = responseMenu.map((food) => FoodItem(id: food['_id'], name: food['foodName'], price: food['foodPrice'])).toList();
    // return fullMenu;
  }

  Future<List<FoodItem>> getMyMenu()async{
    List<FoodItem> menu ;

    Food foodApi = Food();
    fullMenu = await foodApi.getMenu();
    menu = await fullMenu.map((food) => FoodItem(id: food['_id'], name: food['foodName'], price: food['foodPrice'])).toList();

    return menu;
  }

  List<FoodItem> getMenuByCategory(String selectedCategory){
    List<FoodItem> filteredMenu = [];

    // fullMenu.map((food) => 
    //   {
    //     food['foodCategory'].map((category) => {
    //     if( (category['categoryName'] == selectedCategory) && (category['isPresent'] == true) )
    //     filteredMenu.add(FoodItem(id: food['_id'], name: food['foodName'], price: food['foodPrice']))
    //   })
    //   }
    // );

    // print(fullMenu[0]['foodCategory'][0]);
    for( int i = 0; i < fullMenu.length; i++ ){
      for( int j = 0; j < fullMenu[i]['foodCategory'].length; j++ ){
        if( (fullMenu[i]['foodCategory'][j]['categoryName'] == selectedCategory) && (fullMenu[i]['foodCategory'][j]['isPresent'] == true) ){
          print(i);
          print(fullMenu[i]['foodCategory']);
          print(j);
          filteredMenu.add(
            FoodItem(
              id: fullMenu[i]['_id'], 
              name: fullMenu[i]['foodName'], 
              price: fullMenu[i]['foodPrice']
            )
          );
        }
      }
    }

    // print(filteredMenu);

    // print(0);
    // print(0);
    // print(0);
    // print(0);
    // print(0);
    // print(0);
    // print(0);

    return filteredMenu;
  }

}