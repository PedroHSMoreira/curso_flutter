import 'package:flutter/material.dart';
import 'package:loja/datas/product_data.dart';
import 'package:loja/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => SimpleDialog(
                  title: const Text('Olá,'),
                  children: <Widget>[
                    SimpleDialogOption(
                        child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Compre pq você vai...",
                              style: TextStyle(color: Colors.black)),
                          WidgetSpan(
                            child: Icon(Icons.favorite, size: 14),
                          ),
                        ],
                      ),
                    )),
                  ],
                ));
      },
      child: Card(
        child: type == 'grid'
            ? productCol(context, product)
            : productRow(context, product),
      ),
    );
  }

  Widget productCol(BuildContext context, ProductData product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: productText(context, product.title,
                'R\$ ${product.price.toStringAsFixed(2)}'))
      ],
    );
  }

  Widget productRow(BuildContext context, ProductData product) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
            height: 250.0,
          ),
        ),
        Flexible(
          flex: 1,
          child: productText(context, product.title,
              'R\$ ${product.price.toStringAsFixed(2)}'),
        )
      ],
    );
  }

  Widget productText(BuildContext context, String title, String price) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            price,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
