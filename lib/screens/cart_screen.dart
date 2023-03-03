import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/cart_items.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    child: const Text("ORDER NOW"),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                // return Text(cart.items["p${i + 1}"]?.id as String);
                var cartItm = cart.items["p${i + 1}"];
                return CartItems(
                  id: cartItm?.id as String,
                  // productId: cart.items.keys.toList()[i + 1],
                  price: cartItm?.price as double,
                  quantity: cartItm?.quantity as int,
                  title: cartItm?.title as String,
                );
              },
              itemCount: cart.items.length,
            ),
          )
        ],
      ),
    );
  }
}
