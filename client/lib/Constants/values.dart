import 'package:flutter/material.dart';

//color
Color mainColor = Color.fromRGBO(255, 204, 0, 1);
//const String BASE_URL = 'http://localhost:8000';
//Style
final headerStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 56, 56, 56));
final titleStyle2 = TextStyle(fontSize: 16, color: Colors.black45);
final subtitleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
final infoStyle = TextStyle(fontSize: 12, color: Colors.black54);

//Decoration
final roundedRectangle12 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(12),
);

final roundedRectangle4 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(4),
);

final roundedRectangle40 = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
);