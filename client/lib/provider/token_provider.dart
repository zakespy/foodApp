import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Token with ChangeNotifier {
  Map token = {
    'orderId': String,
    'tokenNo': String,
    'isPrepared': bool,
    "orderDetails": Map,
  };

  List<Map> tokenList = [{}];

  Token({required this.tokenList});

  List get TokenList => tokenList;
  int get tokenListLength => tokenList.length;

  bool addToTokenList(Map token) {
    print('token $token');
    tokenList.add(token);
    notifyListeners();
    return true;
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

  List getTokenList() {
    print(tokenList);
    return tokenList;
  }

  void updateToken(String orderId) {
    tokenList.map((e) => {
          if (e['orderId'] == orderId) {e['isPrepared'] = true}
        });
  }
}
