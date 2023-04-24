import 'package:flutter/material.dart';

class Product {
  String name;
  String image;
  int quantity;

  Product({required this.name, required this.image, this.quantity = 0});
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> _products = [
    Product(name: 'Product 1', image: 'image1.jpg'),
    Product(name: 'Product 2', image: 'image2.jpg'),
    Product(name: 'Product 3', image: 'image3.jpg'),
    Product(name: 'Product 4', image: 'image4.jpg'),
    Product(name: 'Product 5', image: 'image5.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: FutureBuilder<List<Product>>(
        future: Future.delayed(Duration(seconds: 2), () => _products),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des données'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return ListTile(
                  leading: Image.asset(product.image),
                  title: Text(product.name),
                  subtitle: Text('Quantité: ${product.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (product.quantity > 0) {
                              product.quantity--;
                            }
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Text('${product.quantity}'),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            product.quantity++;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Checkbox(
                        value: product.quantity > 0,
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked!) {
                              product.quantity = 1;
                            } else {
                              product.quantity = 0;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Aucun produit trouvé'));
          }
        },
      ),
    );
  }
}
