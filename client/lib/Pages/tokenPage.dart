import 'package:flutter/material.dart';

class TokenPage extends StatefulWidget {
  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  late int _tokenNumber;
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _generateTokenNumber();
    _startProcessing();
  }

  void _generateTokenNumber() {
    
    _tokenNumber = DateTime.now().millisecondsSinceEpoch % 10000;
  }

  void _startProcessing() {
   
    Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {
        _isProcessing = false;
      });
    });
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
              '$_tokenNumber',
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