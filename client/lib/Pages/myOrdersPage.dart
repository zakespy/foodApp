import 'package:flutter/material.dart';
import 'package:foodapp/Constants/values.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/provider/my_orders_provider.dart';
import 'package:foodapp/model/orders.dart';
import 'package:foodapp/Pages/orderView.dart';

class ordersPage extends StatefulWidget {
  const ordersPage({super.key});

  @override
  State<ordersPage> createState() => _ordersPageState();
}

class _ordersPageState extends State<ordersPage> {

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    MyOrders myOrdersList = ordersProvider.getOrdersList();

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
              // ...buildHeader(),
              //cart items list
              ListView.builder(
                itemCount: myOrdersList.allOrders.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => orderView(
                            orderList: myOrdersList.allOrders[index].order, 
                            token: myOrdersList.allOrders[index].token,
                            status: myOrdersList.allOrders[index].status,  
                          )
                        )
                      )
                    },
                    child: buildCartItemList(ordersProvider, myOrdersList, myOrdersList.allOrders[index], index)
                  );
                },
              ),
              SizedBox(height: 16),
              Divider(),
              // buildPriceInfo(cart),
              // checkoutButton(cart, context),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildCartItemList(OrdersProvider orders_provider, MyOrders my_order_list, OrderItems order_item, int index) {

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        height: 100,
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              // child: Image.asset(
              //   'assets/dosa.png',
              //   fit: BoxFit.cover,
              //   width: 100,
              //   height: 100,
              // ),
              child: Text(
                'Token no. ${order_item.token}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Container(
                  //   height: 45, 
                  //   child: Text(
                  //     "${order_item.token}",
                  //     style: titleStyle,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            ),
            // DropdownButton(
            //   // value: order_item,
            //   items: order_item.order.map<DropdownMenuItem>((e) => DropdownMenuItem(
            //       value: e,
            //       child: Text("${e['foodName']}")
            //     )
            //   ).toList(), 
            //   onChanged: null,
            // )

            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: order_item.status ? Colors.green[600] : Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 20),
                  child: order_item.status ? Text('Ready', style: titleStyle) : Text('Preparing', style: titleStyle),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}