import 'package:flutter/material.dart';
import 'package:shopapp/models/product_item_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductItemModel> _products = [];
  List<ProductItemModel> get products => _products;
  void addProduct(ProductItemModel product) {
    _products.add(product);
    notifyListeners();
  }
}
