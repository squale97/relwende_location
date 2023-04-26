import 'dart:convert';
import 'package:flutter_ecommerce_app/pages/details_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/example_data.dart';
import 'model/commandeModel.dart';
import 'model/productbyCatModel.dart';

class CommmandeDetailPage extends StatefulWidget {
  List<Produits>? products;
  CommmandeDetailPage({this.products});

  @override
  State<CommmandeDetailPage> createState() => _CommmandeDetailPageState();
}

class _CommmandeDetailPageState extends State<CommmandeDetailPage> {
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
      body: jsonEncode({"id": "1"}),
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

  List<Produits>? productList;
  @override
  void initState() {
    // TODO: implement initState
    productList = widget.products!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode
    Color defaultColor =
        //isDarkMode ? Colors.white.withOpacity(0.8) :

        Colors.black;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3b22a1),
          title: Text(
            "Commandes details",
          ),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Text("Produits",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            Expanded(
              flex: 3,
              child: Card(
                child: Container(
                  height: 700,
                  width: 700,
                  child: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            AppUrl.url +
                                "produitImages/" +
                                productList![index].id.toString(),
                            height: 75,
                            width: 75,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/icons/logo_traite.png",
                                height: 75,
                                width: 75,
                              );
                            },
                          ),
                          title: Text(productList![index].libele!),
                          subtitle: Text(
                              "Qte: " + productList![index]!.index.toString()),
                          trailing: Text("Prix: " +
                              (productList![index]!.index! *
                                      productList![index].prix!)
                                  .toString()),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            /* MaterialButton(
              height: 50,
              minWidth: 200,
              //minWidth: double.infinity,
              //height:60,
              onPressed: () async {
                /*Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              LoginPage()));*/
              },
              color: Color(0xff3b22a1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                "Annuler la commande",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),*/
            TextButton(onPressed: () {}, child: Text("Annuler la commande")),
            Expanded(
              flex: 1,
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Autres produits ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: FutureBuilder<ProductByCategoryModel>(
                    future: fetchProductsByCat(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          /// crossAxisCount: 2,
                          //childAspectRatio: 0.65,
                          // ),
                          itemCount: snapshot.data!.contenu!.length,
                          shrinkWrap: true,
                          primary: false,
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final product_name =
                                snapshot.data!.contenu![index].libele;
                            final description =
                                snapshot.data!.contenu![index].description;
                            final id =
                                snapshot.data!.contenu![index].id.toString();
                            final id_int = snapshot.data!.contenu![index].id;
                            final cat =
                                snapshot.data!.contenu![index].libeleCategorie;
                            final price =
                                snapshot.data!.contenu![index].prix!.toDouble();
                            final color = snapshot.data!.contenu![index].color!;
                            print("le id de l'image est :" + id!);
                            return Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.04,
                                  ),
                                  child: InkWell(
                                    onTap: () => Get.to(
                                      () => DetailsPage(
                                          description: description!,
                                          name: product_name!,
                                          room: cat!,
                                          assetURL: AppUrl.url +
                                              'produitImages/' +
                                              id!,
                                          rating: 5,
                                          price: price,
                                          color: color,
                                          colors: items[0]['colors'],
                                          productId: id_int!,
                                          isLoggedIn: true //widget.isLoggedIn!,
                                          ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.network(
                                          AppUrl.url + 'produitImages/' + id!,
                                          height: size.width * 0.5,
                                          width: size.width * 0.5,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return SizedBox(
                                              width: size.width * 0.5,
                                              height: size.width * 0.5,
                                              child: Align(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: defaultColor,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                "assets/icons/logo_traite.png",
                                                height: size.width * 0.5,
                                                width: size.width * 0.5,
                                                fit: BoxFit
                                                    .contain); /*SizedBox(
                                    width: size.width * 0.5,
                                    height: size.width * 0.5,
                                    child: Align(
                                      child: CircularProgressIndicator(
                                        color: defaultColor,
                                      ),
                                    ),
                                  );*/
                                          },
                                        ),
                                        Text(
                                          cat!,
                                          style: GoogleFonts.poppins(
                                            color: defaultColor,
                                            fontSize: size.height * 0.016,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.5,
                                          child: Text(
                                            product_name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.lato(
                                              color: defaultColor,
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                          width: size.width * 0.3,
                                          child: ListView.builder(
                                            itemCount: 5,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              if (index < 5) {
                                                return Icon(
                                                  Icons.star,
                                                  color: defaultColor,
                                                  size: size.height * 0.025,
                                                );
                                              } else {
                                                return Icon(
                                                  Icons.star_outline,
                                                  color: defaultColor,
                                                  size: size.height * 0.025,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$price\$',
                                              style: GoogleFonts.poppins(
                                                color: defaultColor,
                                                fontSize: size.height * 0.02,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            /* SizedBox(
                                              height: size.width * 0.09,
                                              width: size.width * 0.09,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: defaultColor,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                                child: IconButton(
                                                    onPressed: () async {
                                                      String username =
                                                          "54007038";
                                                      String password =
                                                          "2885351";
                                                      print("clicked");
                                                      String basicAuth = 'Basic ' +
                                                          base64Encode(utf8.encode(
                                                              '$username:$password'));

                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      //Return double
                                                      int ID =
                                                          prefs.getInt('ID');

                                                      final response =
                                                          await http.post(
                                                              Uri.parse(
                                                                AppUrl.url +
                                                                    'cart/update',
                                                              ),
                                                              headers: <String,
                                                                  String>{
                                                                'authorization':
                                                                    basicAuth,
                                                                'Content-Type':
                                                                    'application/json; charset=UTF-8'
                                                              },
                                                              body: jsonEncode({
                                                                "user": ID,
                                                                "product":
                                                                    id_int,
                                                              }));
                                                      if (response.statusCode ==
                                                          200) {
                                                        setState(() {
                                                          //counter =
                                                          //counter + 1;
                                                        });

                                                        //print("le counter est " +
                                                        // counter
                                                        //.toString());
                                                        CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .success,
                                                          text:
                                                              'Produit ajouté avec succès',
                                                          autoCloseDuration:
                                                              const Duration(
                                                                  seconds: 4),
                                                        );

                                                        print("ajouté");
                                                      }

                                                      //Get.to(CartScreen());
                                                      //}
                                                    },
                                                    icon: Icon(
                                                      Icons.shopping_cart,
                                                      //UniconsLine.info_circle,
                                                      color: Colors.white,
                                                      size: size.width * 0.055,
                                                    )),
                                              ),
                                            ),*/
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                    })),
          ]),
        ));
  }
}
