import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
//import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  // Definindo o caminho para o banco de dados firebase.
  final _baseUrl = 'https://shop-cfcb3-default-rtdb.firebaseio.com';
  final List<Product> _items = dummyProducts;

  // Metodo get para pegar os produtos de clone da lista [..._items]
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  // Criar um metodo para adicionar produto
  void addProduct(Product product) {
    // Chamar o metodo post
    http
        .post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode(
        {
          "name": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    )
        .then((response) {
      //Ação que será executada depois da resposta do Firebase.
      // Vamos continuar criando os dados em memoria.
      _items.add(product);
      // sempre que houver uma mudança vai ser chamado o ChangeNotifier
      notifyListeners();
    });
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }
}
