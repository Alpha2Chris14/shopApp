import 'package:flutter/material.dart';
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

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }
}