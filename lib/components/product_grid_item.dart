import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      //Cria um clipe retangular arredondado.
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              // Um widget para exibir antes do título. Normalmente um widget [Icon] ou [IconButton].
              onPressed: () {
                product.toggleFavorite();
              }, // O retorno de chamada que é chamado quando o botão é tocado ou ativado de outra forma. Se for definido como nulo, o botão será desabilitado.
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).hintColor,
            ),
          ), // footer é rodapé da grade.
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).hintColor,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produto adicionado com sucesso!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              cart.addItem(product);
            },
          ),
        ),
        child: GestureDetector(
            child: Image.network(
              //Cria um widget que exibe um [ImageStream] obtido da rede.
              product.imageUrl, // Buscando a imagem do produto.
              fit: BoxFit
                  .cover, // BoxFit.cover é para a imagem cobrir toda a aréa disponivel.
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productDetail,
                arguments: product,
              );

              // Navegação direta
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ProductDatailPage(product: product),
              //   ),
              // );
            }),
      ),
    );
  }
}
