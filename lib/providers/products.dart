import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: "p1",
    //   title: "Red Shirt",
    //   description: "A Red Shirt",
    //   price: 29.99,
    //   imageUrl:
    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzCpMGLxbkmQLdUWbtjmSjysSrrSr2qJJOVw&usqp=CAU",
    // ),
    // Product(
    //   id: "p2",
    //   title: "Red Dress",
    //   description: "A Beautiful Red Dress",
    //   price: 29.99,
    //   imageUrl:
    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnHfVoSCwQuNQL8sJD0-p7rrkh8LJNndMvrw&usqp=CAU",
    // ),
    // Product(
    //   id: "p3",
    //   title: "A Trouser",
    //   description: "A Beautiful Dress",
    //   price: 30.99,
    //   imageUrl:
    //       "https://cdn.suitsupply.com/image/upload/f_auto,q_auto,w_1440/suitsupply/campaigns/ss22/guide/trouser-detail-guide/01-D.jpg",
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProduct() async {
    var url =
        "https://myshopify-c7b40-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      print(json.decode(response.body));
      //return;
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print("Hello to the world");
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData["title"],
            description: prodData["description"],
            price: double.parse(prodData["price"]),
            imageUrl: prodData["imageUrl"]));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    var url =
        "https://myshopify-c7b40-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavourite": product.isFavorite,
          },
        ),
      );
      final newProduct = Product(
        id: json.decode(response.body)["name"],
        // id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((product) => product.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      final url =
          "https://myshopify-c7b40-default-rtdb.firebaseio.com/products/$id.json";
      await http.patch(Uri.parse(url),
          body: json.encode({
            "title": newProduct.title,
            "description": newProduct.description,
            "imageUrl": newProduct.imageUrl,
            "price": newProduct.price,
          }));

      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://myshopify-c7b40-default-rtdb.firebaseio.com/products/$id.json";
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    http.delete(Uri.parse(url)).then((value) {
      existingProduct = null as Product;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
    });
    notifyListeners();
  }

  Product findById(id) {
    return items.firstWhere((element) => element.id == id);
  }
}
