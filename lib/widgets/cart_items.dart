import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  // final String productId;
  final double price;
  final int quantity;
  final String title;
  CartItems({
    required this.id,
    // required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        // Provider.of<Cart>(context, listen: false).removeItem(productId);
        const AlertDialog(
          title: Text("Hello There awaiting fix"),
          icon: Icon(
            Icons.delete,
          ),
        );
      },
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Are you sure? "),
                content: const Text("Do you want to delete this item"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text("No")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: const Text("Yes"))
                ],
              );
            });
      },
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text(
                "\$$price",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${(price * quantity)}"),
            trailing: Text("$quantity X"),
          ),
        ),
      ),
    );
  }
}
