import 'package:flutter/material.dart';
import 'package:foodapp/Constants/values.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/provider/my_orders_provider.dart';
import 'package:foodapp/model/orders.dart';

class orderView extends StatefulWidget {
  // const orderView({super.key});
  List orderList;
  int token;
  bool status;
  orderView({super.key, required this.orderList, required this.token, required this.status});

  @override
  State<orderView> createState() => _orderViewState();
}

class _orderViewState extends State<orderView> {
  ScrollController scrollController = ScrollController();
  late AnimationController animationController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('My Orders'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        // textTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...buildHeader(),
              // cart items list
              ListView.builder(
                itemCount: widget.orderList.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return 
                    buildCartItemList(widget.orderList, widget.orderList[index], index);
                },
              ),
              SizedBox(height: 16),
              Divider(),
              // buildPriceInfo(cart),
              checkoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildHeader() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Text('Order Number ${widget.token}', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      ),
      Divider(),
      Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: widget.status ? Colors.green[600] : Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 20),
            child: widget.status ? Text('Ready', style: headerStyle) : Text('Preparing', style: headerStyle),
          ),
        ],
      ),
    ];
  }

  Widget buildCartItemList( List order_list, Map order_item, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        height: 100,
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.asset(
                'assets/dosa.png',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 45,
                    child: Text(
                      "${order_item['foodName']}   x${order_item['quantity']}",
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     InkWell(
                  //       customBorder: roundedRectangle4,
                  //       onTap: () {
                  //         cartProvider.decreaseQuantity(item);
                  //         animationController.reset();
                  //         animationController.forward();
                  //       },
                  //       child: Icon(Icons.remove_circle),
                  //     ),
                  //     Padding(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                  //       child: Text('${item['quantity']}', style: titleStyle),
                  //     ),
                  //     InkWell(
                  //       customBorder: roundedRectangle4,
                  //       onTap: () {
                  //         cartProvider.increaseQuantity(item);
                  //         animationController.reset();
                  //         animationController.forward();
                  //       },
                  //       child: Icon(Icons.add_circle),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 70,
                    child: Text(
                      '\u{20B9} ${order_item['foodPrice']}',
                      style: titleStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     cartProvider.removeFromCart(item);
                  //     animationController.reset();
                  //     animationController.forward();
                  //   },
                  //   customBorder: roundedRectangle12,
                  //   child: Icon(Icons.delete_sweep, color: Colors.red),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkoutButton() {
    return Container(
      margin: EdgeInsets.only(top: 24, bottom: 64),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
          backgroundColor: mainColor,
          shape: StadiumBorder(),
          splashFactory: InkRipple.splashFactory,
        ),
        child: Text('CLAIM', style: titleStyle),
        onPressed: () {
          // onCheckOutClick(cart, total);
        },
      ),
    );
  }

}