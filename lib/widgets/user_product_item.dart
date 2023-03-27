import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/edit_product_screen.dart';

import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserProductItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.purple,
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      Provider.of<Products>(context, listen: false)
                          .deleteProduct(id);
                    } catch (error) {
                      scaffold.showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Deleting Failed",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
