import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = "https://myshopify-c7b40-default-rtdb.firebaseio.com/orders.json";
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'amount': total,
          'products': cartProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'title': cartProduct.title,
                    'price': cartProduct.price,
                    'quantity': cartProduct.quantity,
                  })
              .toList(),
          'dateTime': timestamp.toIso8601String(),
        }),
      );

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          products: cartProducts,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
