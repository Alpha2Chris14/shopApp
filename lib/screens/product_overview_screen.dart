import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/product_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("myShopify"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert_outlined),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorites"),
              ),
              PopupMenuItem(
                child: Text("Show All"),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cartData, ch) => Badge(
              value: cartData.itemCount.toString(),
              color: Colors.red,
              child: ch as Widget,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}
