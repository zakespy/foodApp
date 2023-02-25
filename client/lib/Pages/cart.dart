import 'package:flutter/material.dart';

import 'package:foodapp/model/items.dart';
import 'package:http/http.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<Item> products = [
      Item(
          name: 'Apple', unit: 'Kg', price: 20, image: 'assets/dosa.png', quantity: 0),
      Item(
          name: 'Mango',
          unit: 'Doz',
          price: 30,
          image: 'assets/dosa.png', quantity: 0),
      Item(
          name: 'Banana',
          unit: 'Doz',
          price: 10,
          image: 'assets/dosa.png', quantity: 0),
      Item(
          name: 'Grapes',
          unit: 'Kg',
          price: 8,
          image: 'assets/dosa.png', quantity: 0),
      Item(
          name: 'Water Melon',
          unit: 'Kg',
          price: 25,
          image: 'assets/dosa.png', quantity: 0),
      Item(name: 'Kiwi', unit: 'Pc', price: 40, image: 'assets/dosa.png', quantity: 0),
      Item(
          name: 'Orange',
          unit: 'Doz',
          price: 15,
          image: 'assets/dosa.png', quantity: 0),
      Item(name: 'Peach', unit: 'Pc', price: 8, image: 'assets/dosa.png', quantity: 0),
      Item(
          name: 'Strawberry',
          unit: 'Box',
          price: 12,
          image: 'assets/dosa.png', quantity: 0),
      Item(
          name: 'Fruit Basket',
          unit: 'Kg',
          price: 55,
          image: 'assets/dosa.png', quantity: 0),
  ];


  

  @override
  Widget build(BuildContext context) {

    int calcTotal() {

      int t = 0;

      for(int i = 0; i < products.length; i++){
        t += (products[i].price * products[i].quantity);
      }

      return t;
    }

    
    int total = calcTotal();
    

    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Padding(
            padding:  const EdgeInsets.all(10),
            child: ElevatedButton(onPressed: ()=>{},
            child: const Text("Widget 1"),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(10),
            child: ElevatedButton(onPressed: ()=>{},
            child: const Text("Widget 2"),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(10),
            child: ElevatedButton(onPressed: ()=>{},
            child: const Text("Widget 3"),
            ),
          ),
        
        ]),
      ),
      appBar: AppBar(
        title: const Text("appbar"),
        actions: [Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5,5,10,5),
              child: Container(
                height: 40,
                width: 40,
                // color: Colors.black,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                // child: IconButton(icon: Icon(Icons.person_2_rounded),onPressed: ()=>{},),
              ),
            )
          ],
        )],
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
                child: 
                ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            height: 75,
                                            width: 75,
                                            image: AssetImage(products[index].image),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          Container(
                                            height: 70,
                                            // color: Colors.red[100],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 13),
                                                  child: Text(products[index].name , 
                                                    style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ),
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
                                                            borderRadius: BorderRadius.circular(3),
                                                            side: BorderSide(width: 1.5, color: Colors.lightBlue.shade200)
                                                          ),
                                                          padding: const EdgeInsets.all(0.0),
                                                          onPressed: (() {
                                                            setState(() {
                                                              if( products[index].quantity > 0 ) {
                                                                products[index].quantity -= 1;
                                                              } else {
                                                                products.removeWhere((e) => e.name==products[index].name);
                                                              }
                                                              total = calcTotal();
                                                            });
                                                          }),
                                                          // child: const Icon(products[index].quantity ? Icons.remove :  Icons.delete),
                                                          child: products[index].quantity > 0 ? const Icon(Icons.remove) :  const Icon(Icons.delete),
                                                        ),
                                                        Text(products[index].quantity.toString() ,
                                                          style: const TextStyle( fontSize: 19, fontWeight: FontWeight.w500 ),
                                                        ),
                                                        MaterialButton(
                                                          height: 20,
                                                          minWidth: 20,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(3),
                                                            side: BorderSide(width: 1.5, color: Colors.lightBlue.shade200)
                                                          ),
                                                          padding: const EdgeInsets.all(0.0),
                                                          onPressed: (() {
                                                            setState(() {
                                                              products[index].quantity += 1;
                                                              total = calcTotal();
                                                            });
                                                          }),
                                                          child: const Icon(Icons.add),
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
                                          mainAxisAlignment: MainAxisAlignment.end,
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
                                            Text('Rs. ${products[index].price * products[index].quantity}',
                                                  style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                            ),
                          );
                        }
                      ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: (){}, 
                          child: const Text("Place Order",
                            style: TextStyle( fontSize: 22, fontWeight: FontWeight.w600 ),
                          ),
                        ),
                        Text('Rs. $total',
                          style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w600 ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}