import 'package:flutter/material.dart';
import 'package:foodapp/Constants/values.dart';
// import 'package:flutter_food_ordering/model/cart_model.dart';
import 'package:foodapp/provider/cart_provider.dart';
// import 'package:flutter_food_ordering/model/food_model.dart';
import 'package:foodapp/model/food.dart';
import 'package:foodapp/Pages/cartPage.dart';
import 'package:provider/provider.dart';

class CartBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cart cartProvider = Provider.of<Cart>(context);
    List cart = cartProvider.getCart();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Container(
              width: 90,
              height: 8,
              decoration: ShapeDecoration(shape: StadiumBorder(), color: Colors.black26),
            ),
          ),
          buildTitle(cartProvider, cart),
          Divider(),
          if (cart.length <= 0) noItemWidget() else buildItemsList(cart),
          Divider(),
          buildPriceInfo(cart),
          SizedBox(height: 8),
          addToCardButton(cart, context),
        ],
      ),
    );
    //});
  }

  Widget buildTitle(Cart cartProider, List cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Your Order', style: headerStyle),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            splashFactory: InkRipple.splashFactory,
            shape: StadiumBorder(),
          ),
          icon: Icon(Icons.delete_forever),
          // color: Colors.red,
          // shape: StadiumBorder(),
          // splashColor: Colors.white60,
          onPressed: cartProider.emptyCart,
          // textColor: Colors.white,
          label: Text('Clear'),
        ),
      ],
    );
  }

  Widget buildItemsList(List cart) {
    return Expanded(
      child: ListView.builder(
        itemCount: cart.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                  // backgroundImage: NetworkImage('$BASE_URL/uploads/${cart.cartItems[index].food.images[0]}'),
                  backgroundImage: AssetImage('assets/dosa.png'),
              ),
              title: Text('${cart[index]['foodName']}', style: subtitleStyle),
              subtitle: Text('\u{20B9} ${cart[index]['foodPrice']}'),
              trailing: Text('x ${cart[index]['quantity']}', style: subtitleStyle),
            ),
          );
        },
      ),
    );
  }

  Widget noItemWidget() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('You don\'t have any order yet!!', style: titleStyle2),
            SizedBox(height: 16),
            Icon(Icons.remove_shopping_cart, size: 40),
          ],
        ),
      ),
    );
  }

  Widget buildPriceInfo(List cart) {
    double total = 0;
    for (Map item in cart) {
      total += item['foodPrice'] * item['quantity'];
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Total:', style: headerStyle),
        Text('\u{20B9} ${total.toStringAsFixed(2)}', style: headerStyle),
      ],
    );
  }

  Widget addToCardButton(cart, context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
          backgroundColor: mainColor,
          shape: StadiumBorder(), 
        ),
        child: Text('CheckOut', style: titleStyle),
        onPressed: cart.length == 0
            ? null
            : () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
              },
        
      ),
    );
  }
}