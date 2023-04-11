import 'dart:convert';
import 'package:flutter_ecommerce_app/main.dart';
import 'package:flutter_ecommerce_app/pages/categories_products/product_byCategorie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/model/categoryModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<CategoryModel> getCategories() async {
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await http.get(
      '${AppUrl.url}categories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print("ok");
      // print(object)

      /* for (int i = 0;
          i < CategoryModel.fromJson(jsonDecode(response.body)).contenu!.length;
          i++) {
        categories.add(CategoryModel.fromJson(jsonDecode(response.body))
            .contenu![i]
            .libele!);
      }*/
      // print(categories);

      // print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(CategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "category $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* bottomSheet: Container(
          //alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
          child: Text("RelwendeLocations ® 2023")),*/
      appBar: AppBar(
        backgroundColor: Color(0xff3b22a1),
        title: Text("Les catégories"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          // implement GridView.builder
          child: FutureBuilder<CategoryModel>(
            future: getCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: snapshot.data!.contenu!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final cat_name = snapshot.data!.contenu![index].libele;
                      final id = snapshot.data!.contenu![index].id;
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductCategoriePage(
                                          catId: id,
                                          catName: cat_name,
                                        )));
                          },
                          child: Card(
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xF0F0F0),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      AppUrl.url +
                                          'categorieImages/' +
                                          id.toString(),
                                      height: 50,
                                      width: 50,
                                    ),
                                    Text(cat_name!),
                                  ],
                                )),
                          ));
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(
                child: SizedBox(),
              );
            },
          )),
    );
  }
}
