import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverViewPage extends StatefulWidget {
  const ProductsOverViewPage({super.key});

  @override
  State<ProductsOverViewPage> createState() => _ProductsOverViewPageState();
}

class _ProductsOverViewPageState extends State<ProductsOverViewPage> {
  bool _showfavoriteOnly = false;

  // importar os produtos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.deepOrange,
        // titleTextStyle: const TextStyle(color: Colors.white),
        title: const Text('Minha Loja'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                // ignore: sort_child_properties_last
                child: Text('Favoritos'),
                value: FilterOptions.favorite,
              ),
              const PopupMenuItem(
                // ignore: sort_child_properties_last
                child: Text('Todos'),
                value: FilterOptions.all,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showfavoriteOnly = true;
                } else {
                  _showfavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badgee(
              value: cart.itemsCount.toString(),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.cart);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(_showfavoriteOnly),
      ),
      drawer: const AppDrawer(),
    );
  }
}
