import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../widgets/product_grid.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      Provider.of<Products>(context).fetchAndSetProduct();
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Future.delayed(Duration.zero).then((_) {
  //     Provider.of<Products>(context, listen: false).fetchAndSetProduct();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("myShopify"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("Only Favorites"),
              ),
              const PopupMenuItem(
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
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isInit ? const CircularProgressIndicator() : ProductGrid(),
    );
  }
}
