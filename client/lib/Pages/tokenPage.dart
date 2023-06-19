// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:foodapp/Pages/home.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/provider/token_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

String orderId = '';
bool _isProcessing = false;
Map token = {};

// resources *************************

// Uri.parse('ws://localhost:5000'),

// ***********************************

// final channel = WebSocketChannel.connect(
//   Uri.parse('ws://localhost:5000'),
// );

// void clientSocket() {

//   final channel = WebSocketChannel.connect(
//     Uri.parse('ws://localhost:5000'),
//     // Uri.parse('ws://localhost:5000'),
//   );

//   channel.sink.add('Hello, WebSocket!');

//   channel.stream.listen((message) {
//     print('Received: $message');
//     bool result = false;
//     TokenPage newtoken = new TokenPage(tokenNumber: 0, orderId: orderId);
//     // newtoken.getToken();
//     if (message == orderId) {
//       // setState(_isProcessing = true);
//       _isProcessing = true;
//       print("Message is true");
//     }
//   });

//   // channel.sink.close(); to close websocket
// }

void initialize(order_Id) {
  orderId = order_Id;
}

class TokenPage extends StatefulWidget {
  TokenPage({super.key, required this.tokenNumber});
  // TokenPage({super.key, required this.tokenNumber, required this.orderId});
  // final String orderId;

  final int tokenNumber;

  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:5000'),
  );

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  // final bool _isProcessing = true;

//   void clientSocket() {

//   // final channel = WebSocketChannel.connect(
//   //   Uri.parse('ws://localhost:5000'),
//   //   // Uri.parse('ws://localhost:5000'),
//   // );

//   widget.channel.sink.add('Hello, WebSocket!');

//   widget.channel.stream.listen((message) {
//     print('Received: $message');
//     // bool result = false;
//     // TokenPage newtoken = new TokenPage(tokenNumber: 0, orderId: orderId);
//     // // newtoken.getToken();
//     // if (message == orderId) {
//     //   // setState(_isProcessing = true);
//     //   _isProcessing = true;
//     //   print("Message is true");
//     // }
//   });

//   // channel.sink.close(); to close websocket
// }

  bool chechToken(orderId) {
    String res = "Processing";
    bool result = getToken(orderId);
    result ? Provider.of<Token>(context).updateToken(orderId) : "";
    // result ? res = "Prepared" : '';
    // return res;
    // return result ? 'Prepared' : 'Processing';
    return result ? true : false;
  }

  Future<List> getTokenList() async {
    List tokenList = await context.read<Token>().TokenList;
    return tokenList;
  }

  bool getToken(orderId) {
    print('order id $orderId');
    // List tokenList = Provider.of<Token>(context,listen: false).TokenList;
    List tokenList = context.read<Token>().getTokenList();
    print('tokenList $tokenList');
    // if (orderId == "true") {
    //   return true;
    // } else {
    //   return false;
    // }
    // List tokenList = Provider.of<Token>(context).TokenList;
    // print('tokenList $tokenList');
    bool isPresent = false;
    tokenList.map((e) => {
          if (orderId == 'true')
            {
              isPresent = true,
              token = e,
            }
          // if (e['orderId'] == orderId) {isPresent = true}
        });
    return isPresent;
  }

  void deleteTokenFromList() {
    bool res = context.read<Token>().removeFromTokenList(token);
    if (res) {
      Navigator.pushReplacement(context, MaterialPageRoute<void>(
      builder: (BuildContext context) => const home(),
    ));
    }
  }

  void initState() {
    print("TokenPage");
    // initialize(widget.orderId);
    // super.initState();
    // clientSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food App'),
      ),
      body: StreamBuilder(
          stream: widget.channel.stream,
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Token Number:',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${widget.tokenNumber}',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  Text(
                      // snapshot.hasData && snapshot.data == "true"
                      snapshot.hasData
                          ? chechToken(snapshot.data)
                              ? 'Prepared'
                              : 'Processing'
                          : 'processing',
                      style: TextStyle(fontSize: 24)),
                  snapshot.hasData
                      ? chechToken(snapshot.data)
                          ? ElevatedButton(
                              child: Text("Claim"),
                              onPressed: () =>
                                  {deleteTokenFromList()},
                            )
                          : Text("Claim ")
                      : Text("Claim "),

                  // _isProcessing
                  //     ? Text(
                  //         'Prepared',
                  //         style: TextStyle(fontSize: 24),
                  //       )
                  //     : Text(
                  //         'Processing',
                  //         style: TextStyle(fontSize: 24),
                  //       ),
                ],
              ),
            );
          }
          // child: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text(
          //         'Token Number:',
          //         style: TextStyle(fontSize: 24),
          //       ),
          //       SizedBox(height: 16),
          //       Text(
          //         '${widget.tokenNumber}',
          //         style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          //       ),
          //       SizedBox(height: 32),
          //       _isProcessing
          //           ? Text(
          //               'Prepared',
          //               style: TextStyle(fontSize: 24),
          //             )
          //           : Text(
          //               'Processing',
          //               style: TextStyle(fontSize: 24),
          //             ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

// class TokenPage extends StatefulWidget {
//   @override
//   _TokenPageState createState() => _TokenPageState();
// }

// class _TokenPageState extends State<TokenPage> {
//   late int tokenNumber;
//   bool _isProcessing = true;

//   @override
//   void initState() {
//     super.initState();
//     _generateTokenNumber();
//     _startProcessing();
//   }

//   void _generateTokenNumber() {

//     tokenNumber = DateTime.now().millisecondsSinceEpoch % 10000;
//   }

//   void _startProcessing() {

//     Future.delayed(Duration(seconds: 5)).then((value) {
//       setState(() {
//         _isProcessing = false;
//       });
//     });
//   }

//   @override

// }