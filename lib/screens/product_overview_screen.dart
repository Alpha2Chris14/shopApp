import 'package:flutter/material.dart';
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
        ],
      ),
      body: ProductGrid(),
    );
  }
}
