import 'package:flutter/material.dart';

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
  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  late List<Product> _filteredProducts;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filteredProducts = products;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Search'),
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
                  title: Text(_filteredProducts[index].name),
                  subtitle: Text(_filteredProducts[index].description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
