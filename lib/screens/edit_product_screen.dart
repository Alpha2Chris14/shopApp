import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';

import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: "",
    title: "",
    description: "",
    price: 0,
    imageUrl: "",
  );

  var _isInit = true;
  var _isLoading = false;
  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final product_id = ModalRoute.of(context)?.settings.arguments;
      if (product_id == null) {
        return;
      }
      final product =
          Provider.of<Products>(context, listen: false).findById(product_id);
      _editedProduct = product;
      _initValue = {
        "title": _editedProduct.title,
        "description": _editedProduct.description,
        "price": _editedProduct.price.toString(),
        // "imageUrl": _editedProduct.imageUrl,
        "imageUrl": "",
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    var value = _imageUrlController.text;

    if (!_imageUrlFocusNode.hasFocus ||
        !value.toString().startsWith("http") ||
        !value.toString().startsWith("https") ||
        !value.toString().endsWith(".png") ||
        !value.toString().endsWith(".jpg") ||
        value.toString().endsWith(".jpeg")) {
      return;
    }
    setState(() {});
  }

  // bool isNumeric(String val) {
  //   if (val == null) {
  //     return false;
  //   }
  //   if (int.parse(val) > 0) {
  //     return true;
  //   }
  //   return false;
  // }

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    // ignore: unnecessary_null_comparison
    print(_editedProduct.id);
    if (_editedProduct.id != "") {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (_) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text(
                  "Oops an error occured",
                ),
                content: const Text("something went wrong"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("Okay"))
                ],
              );
            });
      }
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValue["title"],
                      decoration: const InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value as String,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please provide a value";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue["price"],
                      decoration: const InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: ((_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode)),
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: double.parse(value!),
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please provide a value";
                        }
                        if (double.tryParse(value) == null) {
                          return "Price must be a valid number";
                        }
                        if (double.parse(value) <= 0) {
                          return "Price must be greater than 0";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue["description"],
                      decoration:
                          const InputDecoration(labelText: "Description"),
                      textInputAction: TextInputAction.done,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: value.toString(),
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Please enter a description";
                        }
                        if (value.toString().length < 10) {
                          return "Description should be at least 10 character long";
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 35,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text("Enter a url")
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Image Url"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.imageUrl,
                                imageUrl: value.toString(),
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                            onFieldSubmitted: (_) {
                              // FocusScope.of(context).requestFocus(_priceFocusNode);
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please enter a url";
                              }
                              if (!value.toString().startsWith("http") ||
                                  !value.toString().startsWith("https")) {
                                return "Please enter a valid url";
                              }
                              // if (!value.toString().endsWith(".png") ||
                              //     !value.toString().endsWith(".jpg") ||
                              //     !value.toString().endsWith(".jpeg")) {
                              //   return "Please enter a valid url";
                              // }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
                      child: ElevatedButton.icon(
                        onPressed: _saveForm,
                        icon: Icon(Icons.save),
                        label: Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
