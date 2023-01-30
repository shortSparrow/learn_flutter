import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_shop/providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = '/product_details';

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<ProductProvider>(context, listen: false)
        .findProductById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
    );
  }
}
