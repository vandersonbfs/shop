import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDatailPage extends StatelessWidget {
  const ProductDatailPage({
    super.key,
    required product,
  });

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            
            Text(
              'R\$ ${product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
             padding: const EdgeInsets.symmetric(horizontal: 10),
             width: double.infinity,
             child: Text(
              product.description,
              textAlign: TextAlign.center,
             ),

            ),
          ],
        ),
      ),
    );
  }
}
