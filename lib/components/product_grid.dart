import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final showfavoriteOnly;

  const ProductGrid(
    this.showfavoriteOnly, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Obtendo a lista de produtos a partir do Privider
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = 
    showfavoriteOnly? provider.favoriteItems: provider.items;

    return GridView.builder(
      itemCount: loadedProducts
          .length, // Passar o tamanho da lista para montar com a quantidade certa.
      // itemBuilder define como será construido cada elemento dentro do GridView.
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (_) => loadedProducts[i],
        child: const ProductGridItem(),
      ), // Buscando o item dentro de components.
      // Sliver define que é uma aréa rolavel.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Exibe dois elementos em cada linha.
        childAspectRatio: 3 / 2, // Dimensão de cada elemento
        crossAxisSpacing: 10, // Espaçamento no eixo crusado de 10.
        mainAxisSpacing: 10, // Espaçamento no eixo principal de 10.
      ),
    );
  }
}
