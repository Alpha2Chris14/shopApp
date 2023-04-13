import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exception.dart';
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

  final String _token;
  Products(this._token);
  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProduct() async {
    try {
      final url =
          "https://myshopify-c7b40-default-rtdb.firebaseio.com/products.json?auth=$_token";

      final response = await http.get(Uri.parse(url));
      //return;
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadedProducts = [];
      // print(extractedData);
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData["title"],
            description: prodData["description"],
            price: prodData["price"],
            imageUrl: prodData["imageUrl"]));
      });

      // print("Hello $loadedProducts");
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw HttpException("swato");
    }
  }

  Future<void> addProduct(Product product) async {
    var url =
        "https://myshopify-c7b40-default-rtdb.firebaseio.com/products.json?auth=$_token";
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
          "https://myshopify-c7b40-default-rtdb.firebaseio.com/products/$id.json?auth=$_token";
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
        "https://myshopify-c7b40-default-rtdb.firebaseio.com/products/$id.json?auth=$_token";
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);

      notifyListeners();
      throw HttpException("Could not delete product");
    }
    existingProduct = null as Product;
  }

  Product findById(id) {
    return items.firstWhere((element) => element.id == id);
  }
}
