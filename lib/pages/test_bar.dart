import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/data/example_data.dart';
import 'package:flutter_ecommerce_app/pages/details_page.dart';
import 'package:get/get.dart';

import 'model/productbyCatModel.dart';

class Product {
  final String name;
  final String description;

  const Product({required this.name, required this.description});
}

final List<Product> products = [
  Product(
      name: 'T-shirt',
      description:
          'A comfortable and stylish piece of clothing, perfect for casual occasions.'),
  Product(
      name: 'Jeans',
      description:
          'A durable and versatile pair of pants, suitable for many different outfits.'),
  Product(
      name: 'Sneakers',
      description:
          'A trendy and comfortable type of footwear, ideal for everyday wear.'),
];

class ProductSearchPage extends StatefulWidget {
  List<ContenuS>? prods;
  bool? isLoggedIn;
  ProductSearchPage({this.prods, this.isLoggedIn});
  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  late List<ContenuS> _filteredProducts;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.prods!;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = widget.prods!
          .where((product) =>
              product.libele!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3b22a1),
        title: Text('Trouver un produit'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Get.to(
                    () => DetailsPage(
                      description: _filteredProducts[index].description!,
                      name: _filteredProducts[index].libele!,
                      room: _filteredProducts[index].libeleCategorie!,
                      assetURL: AppUrl.url +
                          'produitImages/' +
                          _filteredProducts[index].id.toString(),
                      rating: 5,
                      price: _filteredProducts[index].prix!.toDouble(),
                      color: _filteredProducts[index].color!,
                      colors: items[0]['colors'],
                      productId: _filteredProducts[index].id!,
                      isLoggedIn: widget.isLoggedIn!,
                    ),
                  ), //{Navigator.push(context, MaterialPageRoute(builder: (builder)))},
                  title: Text(_filteredProducts[index].libele!),
                  subtitle: Text(_filteredProducts[index].libeleCategorie!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
