import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text("\$${order.amount}"),
          subtitle: Text(order.dateTime.toString()),
          // subtitle: Text(
          //   DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
          // ),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
