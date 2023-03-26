import 'package:flutter/material.dart';

import 'package:foodapp/Widgets/cartBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/Constants/values.dart';
import 'package:foodapp/provider/cart_provider.dart';
import 'package:foodapp/model/food.dart';

class FoodCard extends StatefulWidget {
  final FoodItem food;
  FoodCard(this.food);

  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> with SingleTickerProviderStateMixin {
  FoodItem get food => widget.food;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: roundedRectangle12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildImage(),
                buildTitle(),
                // buildRating(),
                buildPriceInfo(),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  // color: mainColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                ),
                // child: Text(food.shop.name),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Container(
      height: MediaQuery.of(context).size.width / 2.8,
      margin: const EdgeInsets.only(bottom: 11),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        child: Image.asset(
          "assets/dosa.png",
          fit: BoxFit.cover,
          // loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
          //   if (progress == null) return child;
          //   return Center(
          //     child: Padding(
          //       padding: EdgeInsets.all(32),
          //       child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes : null),
          //     ),
          //   );
          // },
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            food.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: titleStyle,
          ),
          // Text(
          //   food.description,
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: infoStyle,
          // ),
        ],
      ),
    );
  }

  // Widget buildRating() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 4, right: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         RatingBar(
  //           initialRating: 5.0,
  //           direction: Axis.horizontal,
  //           itemCount: 5,
  //           itemSize: 14,
  //           unratedColor: Colors.black,
  //           itemPadding: EdgeInsets.only(right: 4.0),
  //           ignoreGestures: true,
  //           itemBuilder: (context, index) => Icon(Icons.star, color: mainColor),
  //           onRatingUpdate: (rating) {},
  //         ),
  //         Text('(${food.rating})'),
  //       ],
  //     ),
  //   );
  // }

  Widget buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8,bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '\Rs ${food.price}',
            style: titleStyle,
          ),
          Card(
            margin: EdgeInsets.only(right: 0),
            shape: roundedRectangle4,
            color: mainColor,
            child: InkWell(
              onTap: (() => {
                if (context.read<Cart>().addToCart({ "foodName":"${food.name}", "foodPrice":food.price })) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                    content: Text('${food.name} added to cart'),
                    action: SnackBarAction(
                      label: 'view',
                      onPressed: showCart,
                    ),
                    duration: Duration(milliseconds: 1500),
                  ),
                  )
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text('You can\'t order from multiple shop at the same time'),
                    duration: Duration(milliseconds: 1500),
                  ),
                  )
                }
              }),
              splashColor: Colors.white70,
              // splashColor: Color.fromARGB(179, 0, 0, 0),
              customBorder: roundedRectangle4,
              child: Icon(Icons.add),
            ),
          ) 
        ],
      ),
    );
  }

  // addItemToCard() {
  //   // bool isAddSuccess = Provider.of<Cart>(context, listen: true).addToCart({"foodName":"${food.name}"});
  //   bool isAddSuccess = Provider.of<Cart>(context, listen: true).addToCart({"foodName":"${food.name}"});
  //   print(isAddSuccess);

  //   if (isAddSuccess) {
  //     final snackBar = SnackBar(
  //       content: Text('${food.name} added to cart'),
  //       // action: SnackBarAction(
  //       //   label: 'view',
  //       //   onPressed: showCart,
  //       // ),
  //       duration: Duration(milliseconds: 1500),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else {
  //     final snackBar = SnackBar(
  //       content: Text('You can\'t order from multiple shop at the same time'),
  //       duration: Duration(milliseconds: 1500),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  showCart() {
    showModalBottomSheet(
      shape: roundedRectangle40,
      context: context,
      builder: (context) => CartBottomSheet(),
    );
  }
}