import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Token with ChangeNotifier {
  Map token = {
    'orderId': String,
    'name': String,
    'isPrepared': bool,
    "orderDetails": Map,

  };

  List<Map> tokenList = [{}];

  Token({required this.tokenList});

  List get TokenList => tokenList;
  int get tokenListLength => tokenList.length;

  void addToTokenList(Map token) {
    tokenList.add(token);
    notifyListeners();
  }

  void removeFromTokenList(Map token) {
    tokenList.remove(token);
    notifyListeners();
  }

  Map getToken(String orderId) {
    Map token = {};
    tokenList.map((e) => {
          if (e['orderId'] == orderId)
            {
              token = e,
            }
        });
    return token;
  }

  void updateToken(Map token){
    tokenList.map((e) => {
      if(e['orderId'] == token['orderId']){
        e['isPrepared'] = true
      }
    });
  }
}
