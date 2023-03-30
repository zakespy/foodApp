import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void clientSocket() {
  // var webSocket = new WebSocket('ws://localhost:5000');
  // webSocket.onMessage.listen((e) {
  //   print("Received Data");
  //   print(e.data);
  // });

  // webSocket.send("Hiii I m client");
  print("Client");
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://localhost:5000'),
  );

  channel.sink.add('Hello, WebSocket!');

  channel.stream.listen((message) {
    print('Received: $message');
  });

  // channel.sink.close(); to close websocket
}

class TokenPage extends StatefulWidget {
  const TokenPage({super.key, required this.tokenNumber});

  final int tokenNumber;

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  final bool _isProcessing = true;

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
      body: Center(
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
            _isProcessing
                ? Text(
                    'Processing',
                    style: TextStyle(fontSize: 24),
                  )
                : Text(
                    'Prepared',
                    style: TextStyle(fontSize: 24),
                  ),
          ],
        ),
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
