import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: "p1",
      title: "Red Shirt",
      description: "A Red Shirt",
      price: 29.99,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzCpMGLxbkmQLdUWbtjmSjysSrrSr2qJJOVw&usqp=CAU",
    ),
    Product(
      id: "p2",
      title: "Red Dress",
      description: "A Beautiful Red Dress",
      price: 29.99,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnHfVoSCwQuNQL8sJD0-p7rrkh8LJNndMvrw&usqp=CAU",
    ),
    Product(
      id: "p3",
      title: "A Trouser",
      description: "A Beautiful Dress",
      price: 30.99,
      imageUrl:
          "https://cdn.suitsupply.com/image/upload/f_auto,q_auto,w_1440/suitsupply/campaigns/ss22/guide/trouser-detail-guide/01-D.jpg",
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  void addProduct(Product product) {
    var url = "https://myshopify-c7b40-default-rtdb.firebaseio.com/products";
    http.post(
      Uri.parse(url),
      body: json.encode(
        {
          "title": product.title,
          "description": product.title,
          "price": product.title,
          "imageUrl": product.imageUrl,
          "isFavourite": product.isFavorite,
        },
      ),
    );
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((product) => product.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print("...");
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  Product findById(id) {
    return items.firstWhere((element) => element.id == id);
  }
}
