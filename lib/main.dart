import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get product => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Componente Grid de Produtos',

        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(0, 30, 32, 34),
            brightness: Brightness.dark,
            primary: Colors.deepOrange,
            secondary: const Color.fromARGB(0, 44, 46, 50),
            tertiary: const Color.fromARGB(0, 238, 28, 28),
          ),
          fontFamily: 'Lato',
        ),
        // home: const ProductsOverViewPage(),
        routes: {
          AppRoutes.home: (ctx) => const ProductsOverViewPage(),
          AppRoutes.productDetail: (ctx) => ProductDatailPage(product: product),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
