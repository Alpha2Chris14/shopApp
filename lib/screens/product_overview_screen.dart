import 'package:flutter/material.dart';
import 'package:shopapp/widgets/product_item.dart';
import '../models/product.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("myShopify"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return GridTile(
            child: ProductItem(
              id: loadedProducts[index].id,
              title: loadedProducts[index].title,
              imageUrl: loadedProducts[index].imageUrl,
            ),
          );
        },
        itemCount: loadedProducts.length,
      ),
    );
  }
}
