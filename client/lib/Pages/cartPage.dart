import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/model/items.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartState();
}

class _CartState extends State<CartPage> {
  // List products = context.read<Cart>().cartLength;

  static get index => null;

  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
  }

  _handlePaymentSuccess( PaymentSuccessResponse response ) {
    
  }

  _handlePaymentError() {

  }

  _handleExternalWallet() {

  }

  @override
  void dispose() {
    _razorpay.clear();
    
    super.dispose();
  }

  // void createOrder() async {
  //   String keyId = 'rzp_test_rk34q3MXaI4tBi';
  //   String keySec = 'T5RC8mNXy9yJANYD6QLdEUPH';
    
  //   String basicAuth = 'Basic ${base64Encode(utf8.encode('$keyId:$keySec'))}';

  //   Map<String, dynamic> body = {
  //     "amount": 100,
  //     "currency": "INR",
  //     "receipt": "rcpt_id_1"
  //   };

    
  // }

  void createOrder() async {
    var res = await http.post( Uri.parse("http://localhost:8000/api/payment/createOrder"),
                      body: jsonEncode({
                        "amount": 100
                      }),
                      headers: {
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                      }
                    ); 

    if( res.statusCode == 201 ){
      orderCheckout( jsonDecode(res.body)['order']['id'], jsonDecode(res.body)['order']['amount'] );
    }

  }

  void orderCheckout( orderId, amount ) async {
    var options = {
      'key': 'rzp_test_rk34q3MXaI4tBi',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60*5, // in seconds
      'prefill': {
        'contact': '1234567890',
        'email': 'testuser1@example.com'
      }
    };

    _razorpay.open(options);
  }

  void verifySignature( { String? signature, String? paymentId, String? orderId} ) async {
    Map<String, dynamic> body = {
      "order_id": orderId,
      "razorpay_payment_id": paymentId,
      "razorpay_signature":signature
    };

    var res = await http.post( Uri.parse("http://localhost:8000/api/payment/verifySignature"),
                      body: body,
                      headers: {
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                      }
                    );

    if( res.statusCode == 200 ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
          )
      );
    }
  }

  List<Item> products = [
    Item(
        name: 'Apple',
        unit: 'Kg',
        price: 20,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Mango',
        unit: 'Doz',
        price: 30,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Banana',
        unit: 'Doz',
        price: 10,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Grapes',
        unit: 'Kg',
        price: 8,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Water Melon',
        unit: 'Kg',
        price: 25,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Kiwi',
        unit: 'Pc',
        price: 40,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Orange',
        unit: 'Doz',
        price: 15,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Peach',
        unit: 'Pc',
        price: 8,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Strawberry',
        unit: 'Box',
        price: 12,
        image: 'assets/dosa.png',
        quantity: 0),
    Item(
        name: 'Fruit Basket',
        unit: 'Kg',
        price: 55,
        image: 'assets/dosa.png',
        quantity: 0),
  ];

  @override
  Widget build(BuildContext context) {
    int calcTotal() {
      int t = 0;
      print(context.read<Cart>().cartLength);
      for (int i = 0; i < context.read<Cart>().cartLength; i++) {
        print("Cart ");
        t += (context.read<Cart>().items[i]['quantity'] *
            context.read<Cart>().items[i]['foodPrice']) as int;
        // print(context.read<Cart>().items[1]['quantity']);
        // t += (context.read<Cart>().items[i]['quantity'] * context.read<Cart>().items[i]['foodPrice']);
      }
      // for (int i = 0; i < products.length; i++) {
      //   t += (products[i].price * products[i].quantity);
      // }

      return t;
    }

    int total = calcTotal();

    return Scaffold(
        drawer: Drawer(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Widget 1"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Widget 2"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Widget 3"),
                  ),
                ),
              ]),
        ),
        appBar: AppBar(
          title: const Text("appbar"),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                  child: Container(
                    height: 40,
                    width: 40,
                    // color: Colors.black,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    // child: IconButton(icon: Icon(Icons.person_2_rounded),onPressed: ()=>{},),
                  ),
                )
              ],
            )
          ],
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     child: const Text("Your Cart",
            //       style: TextStyle(
            //         fontSize: 30,

            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Expanded(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: context.read<Cart>().cartLength,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Image(
                                          height: 75,
                                          width: 75,
                                          image: AssetImage(
                                              // context.read<Cart>()
                                              //     .items[index]['foodImage']
                                              "assets/dosa.png"
                                                  ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Container(
                                          height: 70,
                                          // color: Colors.red[100],
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13),
                                                child: Text(
                                                  context.read<Cart>()
                                                      .items[index]['foodName'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.amber[200],
                                                child: SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    children: [
                                                      MaterialButton(
                                                        height: 20,
                                                        minWidth: 20,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            side: BorderSide(
                                                                width: 1.5,
                                                                color: Colors
                                                                    .lightBlue
                                                                    .shade200)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        onPressed: (() {
                                                          setState(() {
                                                            if (context
                                                        .read<Cart>()
                                                                        .items[index]
                                                                    [
                                                                    'quantity'] >
                                                                0) {
                                                             context
                                                        .read<Cart>()
                                                                  .decreaseQuantity(
                                                                      context
                                                        .read<Cart>()
                                                                          .items[index]);
                                                              // context.read<Cart>().items[index]['quantity'] -= 1;
                                                            } else {
                                                              context
                                                        .read<Cart>()
                                                                  .removeFromCart(
                                                                      context
                                                        .read<Cart>()
                                                                          .items[index]);
                                                            }
                                                            total = calcTotal();
                                                          });
                                                        }),
                                                        // child: const Icon(products[index].quantity ? Icons.remove :  Icons.delete),
                                                        child: context.read<Cart>()
                                                              .items[index]['quantity']>
                                                                0
                                                            ? const Icon(
                                                                Icons.remove)
                                                            : const Icon(
                                                                Icons.delete),
                                                      ),
                                                      Text(
                                                        context.read<Cart>()
                                                      .items[index]['quantity'].toString(),
                                                        style: const TextStyle(
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      MaterialButton(
                                                        height: 20,
                                                        minWidth: 20,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            side: BorderSide(
                                                                width: 1.5,
                                                                color: Colors
                                                                    .lightBlue
                                                                    .shade200)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        onPressed: (() {
                                                          setState(() {
                                                            context.read<Cart>().increaseQuantity(context.read<Cart>().items[index]);
                                                            total = calcTotal();
                                                          });
                                                        }),
                                                        child: const Icon(
                                                            Icons.add),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 70,
                                      // color: Colors.blue[100],
                                      // alignment: Alignment.topCenter,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // MaterialButton(
                                          //   height: 20,
                                          //   minWidth: 20,
                                          //   onPressed: (() {
                                          //     setState(() {
                                          //        products.removeWhere((e) => e.name==products[index].name);
                                          //     });
                                          //   }),
                                          //   child: const Icon(Icons.delete, size: 20,),
                                          // ),
                                          Text(
                                            'Rs. ${context.read<Cart>()
                                                      .items[index]['quantity'] * context.read<Cart>()
                                                      .items[index]['foodPrice']}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          );
                        }),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Place Order",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            'Rs. $total',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
