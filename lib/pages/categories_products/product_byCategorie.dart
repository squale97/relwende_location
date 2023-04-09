import 'dart:convert';
import 'package:flutter_ecommerce_app/widgets/homePage/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/data/example_data.dart';
import '../../appUrl.dart';
import '../model/productbyCatModel.dart';

class ProductCategoriePage extends StatefulWidget {
  late int? catId;
  late String? catName;
  ProductCategoriePage({this.catId, this.catName});

  @override
  State<ProductCategoriePage> createState() => _ProductCategoriePageState();
}

class _ProductCategoriePageState extends State<ProductCategoriePage> {
  Future<ProductByCategoryModel> fetchProductsByCat() async {
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.post(
      AppUrl.url + "produitByCategorie",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
      body: jsonEncode({"id": widget.catId.toString()}),
    );
    //print(response.statusCode);
    if (response.statusCode == 200) {
      //print("ok");
      //  print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(ProductByCategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return ProductByCategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Products');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode
    Color defaultColor =
        isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black;
    Color secondColor = /*isDarkMode ?*/ Colors.black /*: Colors.white*/;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catName!),
        backgroundColor: Color(0xff3b22a1),
      ),
      body: SizedBox(
        width: size.width,
        child: FutureBuilder<ProductByCategoryModel>(
          future: fetchProductsByCat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemCount: snapshot.data!.contenu!.length,
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final product_name = snapshot.data!.contenu![index].libele;
                  final description =
                      snapshot.data!.contenu![index].description;
                  final id = snapshot.data!.contenu![index].id.toString();
                  final cat = snapshot.data!.contenu![index].libeleCategorie;
                  final price = snapshot.data!.contenu![index].prix!.toDouble();
                  print("le id de l'image est :" + id!);
                  return buildProduct(
                    product_name!,
                    description!,
                    cat!,
                    AppUrl.url + 'produitImages/' + id!,
                    5,
                    price!,
                    items[index]['colors'],
                    defaultColor, //default color
                    secondColor, //second color
                    size, // device size
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
