import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

bool _isProcessing = false;
final channel = WebSocketChannel.connect(
  Uri.parse('ws://10.0.2.2:5000'),
);
void clientSocket() {
  // var webSocket = new WebSocket('ws://10.0.2.2:5000');
  // webSocket.onMessage.listen((e) {
  //   print("Received Data");
  //   print(e.data);
  // });

  // webSocket.send("Hiii I m client");
  print("Client");
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:5000'),
  );

  channel.sink.add('Hello, WebSocket!');

  channel.stream.listen((message) {
    print('Received: $message');
    if (message == "true") {
      // setState(_isProcessing = true);
      _isProcessing = true;
      print("Message is true");
    }
  });

  // channel.sink.close(); to close websocket
}

class TokenPage extends StatefulWidget {
  TokenPage({super.key, required this.tokenNumber});

  final int tokenNumber;

  final channel = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:5000'),
  );

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  // final bool _isProcessing = true;

  void initState() {
    // super.initState();
    clientSocket();
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
                    snapshot.hasData && snapshot.data == "true"?'Prepared':'Processing',
                    style: TextStyle(fontSize: 24)
                  ),
                  snapshot.hasData && snapshot.data == "true"?
                  ElevatedButton(child: Text("Claim"),onPressed: ()=>{
                    Navigator.pushNamed(context, '/')
                  },):
                  Text("Claim ")
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
