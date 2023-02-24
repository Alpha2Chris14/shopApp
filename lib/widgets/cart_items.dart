import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  CartItems({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
