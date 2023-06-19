import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/Constants/values.dart';
import 'package:foodapp/Pages/tokenPage.dart';
import 'package:foodapp/model/orders.dart';
import 'package:foodapp/provider/token_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/provider/cart_provider.dart';
import 'package:foodapp/provider/my_orders_provider.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:toast/toast.dart';

class CartPage extends StatefulWidget {
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  var now = DateTime.now();
  get weekDay => DateFormat('EEEE').format(now);
  get day => DateFormat('dd').format(now);
  get month => DateFormat('MMMM').format(now);
  double oldTotal = 0;
  double total = 0;

  ScrollController scrollController = ScrollController();
  late AnimationController animationController;

  final _razorpay = Razorpay();
  late String order_Id;

  Future<http.Response> getToken(Map res) async {
    var tokenRes = await http.post(
        Uri.parse("http://localhost:8000/api/order/createToken"),
        body: jsonEncode(res),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    return tokenRes;
  }

  Future<http.Response> addOrder(Map order) async {
    var res = await http.post(
        Uri.parse("http://localhost:8000/api/order/addOrder"),
        body: jsonEncode(order),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    return res;
  }

  Future<bool> addToken(tokenNo, orderId) async {
    Map newToken = {'tokenNo': tokenNo, 'orderId': orderId};
    final tokenData = await context.read<Token>().addToTokenList(newToken);
    print("true $tokenData");
    // final tokenData = await Provider.of<Token>(context).addToTokenList(
    //     {'tokenNo': tokenNo, 'orderId': orderId, 'isPrepared': false});
    return true;
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    verifySignature(
        signature: response.signature,
        paymentId: response.paymentId,
        // orderId: response.orderId
        orderId: order_Id);

    var res = await http.post(
        Uri.parse("http://localhost:8000/api/payment/paymentSuccess"),
        body: jsonEncode({"order_id": order_Id}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    print("res type");
    print(jsonDecode(res.body)['order']);
    http.Response tokenRes = await getToken(jsonDecode(res.body)['order']);
    // Map tokenRes = (await getToken(jsonDecode(res.body)['order'])) ;
    // print("token no");
    // print(jsonDecode(tokenRes.body)['tokenNo']);
    print(jsonDecode(res.body)['order']);
    Map newOrder = jsonDecode(res.body)['order'];
    newOrder['tokenNo'] = jsonDecode(tokenRes.body)['tokenNo'];
    // print("newOrder");
    // print(newOrder);
    addOrder(newOrder);

    // ignore: use_build_context_synchronously
    print('start');
    Provider.of<OrdersProvider>(context, listen: false).addToOrders(Provider.of<Cart>(context, listen: false).getCart(), jsonDecode(tokenRes.body)['tokenNo']);
    print('done');

    addToken(jsonDecode(tokenRes.body)['tokenNo'],
        jsonDecode(res.body)['order']['order_id']);
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TokenPage(
                  // tokenNumber: 1,
                  tokenNumber: jsonDecode(tokenRes.body)['tokenNo'],
            )
        )
    );
    // Navigator.pushNamed(context, '/token');

    // List<Map> cartForServer = Provider.of<Cart>(context, listen: false).getCart().map((e) => {

    // }).toList();
    List tempCart = Provider.of<Cart>(context, listen: false).getCart();
    print(tempCart);
    
    Future.delayed(const Duration(milliseconds: 2000), () async {


    var orderConfirmation = await http.post(
      Uri.parse("http://localhost:8000/api/order/addOrder"),
      body: jsonEncode({
        "tokenNo": jsonDecode(tokenRes.body)['tokenNo'],
        "order_id": order_Id,
        "orderDetails": tempCart
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      } 
    );

    await http.post(
      Uri.parse("http://localhost:8000/api/dayOrder/addDayOrder"),
      body: jsonEncode({
        "tokenNo": jsonDecode(tokenRes.body)['tokenNo'],
        "orderDetails": Provider.of<Cart>(context, listen: false).getCart(),
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }
    );
    });


    Provider.of<Cart>(context, listen: false).emptyCart();


  }

  _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? " "),
      ),
    );
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.walletName ?? ""),
    ));
  }

  void createOrder(amount) async {
    var res = await http.post(
        Uri.parse("http://localhost:8000/api/payment/createOrder"),
        body: jsonEncode({"amount": amount}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    order_Id = jsonDecode(res.body)['order']['id'];

    if (res.statusCode == 201) {
      orderCheckout(jsonDecode(res.body)['order']['id'],
          jsonDecode(res.body)['order']['amount']);
    }
  }

  void orderCheckout(orderId, amount) async {
    var options = {
      'key': 'rzp_test_rk34q3MXaI4tBi',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60 * 5, // in seconds
      'prefill': {'contact': '1234567890', 'email': 'testuser1@example.com'}
    };

    _razorpay.open(options);
  }

  void verifySignature(
      {String? signature, String? paymentId, String? orderId}) async {
    Map<String, dynamic> body = {
      "order_id": orderId,
      "razorpay_payment_id": paymentId,
      "razorpay_signature": signature
    };

    var res = await http.post(
        Uri.parse("http://localhost:8000/api/payment/verifySignature"),
        body: body,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.body),
      ));
    }
  }

  onCheckOutClick(List cart, double totalAmount) async {
    try {
      // List<Map> data = List.generate(cart.cartItems.length, (index) {
      //   return {"id": cart.cartItems[index].food.id, "quantity": cart.cartItems[index].quantity};
      // }).toList();

      // var response = await Dio().post('$BASE_URL/api/order/food', queryParameters: {"token": token}, data: data);
      // print(response.data);

      // if (response.data['status'] == 1) {
      //   cart.clearCart();
      //   Navigator.of(context).pop();
      // } else {
      //   Toast.show(response.data['message'], context);
      // }

      createOrder(totalAmount);
    } catch (ex) {
      print(ex.toString());
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    _razorpay.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Cart cartProvider = Provider.of<Cart>(context);
    OrdersProvider ordersListProvider = Provider.of<OrdersProvider>(context);
    List cart = cartProvider.getCart();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('CheckOut'),
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
              //cart items list
              ListView.builder(
                itemCount: cart.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return buildCartItemList(cartProvider, cart, cart[index]);
                },
              ),
              SizedBox(height: 16),
              Divider(),
              buildPriceInfo(cart),
              checkoutButton(cart, context),
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
        child: Text('Cart', style: headerStyle),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 0),
        child: Text('$weekDay, ${day}th of $month ', style: headerStyle),
      ),
      TextButton(
        child: Text('+ Add to order'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ];
  }

  Widget buildPriceInfo(List cart) {
    oldTotal = total;
    total = 0;
    for (Map item in cart) {
      total += item['foodPrice'] * item['quantity'];
    }
    //oldTotal = total;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Total:', style: headerStyle),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Text(
                '\u{20B9} ${lerpDouble(oldTotal, total, animationController.value)?.toStringAsFixed(2)}',
                style: headerStyle);
          },
        ),
      ],
    );
  }

  Widget checkoutButton(List cart, context) {
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
        child: Text('Checkout', style: titleStyle),
        onPressed: () {
          onCheckOutClick(cart, total);
        },
      ),
    );
  }

  Widget buildCartItemList(Cart cartProvider, List cart, Map item) {
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
                      item['foodName'],
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        customBorder: roundedRectangle4,
                        onTap: () {
                          cartProvider.decreaseQuantity(item);
                          animationController.reset();
                          animationController.forward();
                        },
                        child: Icon(Icons.remove_circle),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                        child: Text('${item['quantity']}', style: titleStyle),
                      ),
                      InkWell(
                        customBorder: roundedRectangle4,
                        onTap: () {
                          cartProvider.increaseQuantity(item);
                          animationController.reset();
                          animationController.forward();
                        },
                        child: Icon(Icons.add_circle),
                      ),
                    ],
                  )
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
                      '\u{20B9} ${item['foodPrice']}',
                      style: titleStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cartProvider.removeFromCart(item);
                      animationController.reset();
                      animationController.forward();
                    },
                    customBorder: roundedRectangle12,
                    child: Icon(Icons.delete_sweep, color: Colors.red),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
