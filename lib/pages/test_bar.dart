import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String image;
  final double price;

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.price});
}

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _getProducts();
  }

  Future<List<Product>> _getProducts() async {
    // simulation d'une requête pour obtenir les produits
    await Future.delayed(Duration(seconds: 2));
    return [
      Product(
          id: 1,
          name: "Produit 1",
          image: "https://via.placeholder.com/150",
          price: 10.0),
      Product(
          id: 2,
          name: "Produit 2",
          image: "https://via.placeholder.com/150",
          price: 20.0),
      Product(
          id: 3,
          name: "Produit 3",
          image: "https://via.placeholder.com/150",
          price: 30.0),
      Product(
          id: 4,
          name: "Produit 4",
          image: "https://via.placeholder.com/150",
          price: 40.0),
      Product(
          id: 5,
          name: "Produit 5",
          image: "https://via.placeholder.com/150",
          price: 50.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panier"),
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Une erreur est survenue : ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Aucun produit trouvé."),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(product.image),
                    title: Text(product.name),
                    subtitle: Text("\$${product.price}"),
                    trailing: QuantitySelector(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _quantity > 0,
          onChanged: (value) {
            setState(() {
              _quantity = value! ? 1 : 0;
            });
          },
        ),
        IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _quantity = _quantity - _quantity > 0 ? _quantity - 1 : 0;
              });
            }),
        Text(_quantity.toString()),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _quantity = _quantity + 1;
            });
          },
        ),
      ],
    );
  }
}
