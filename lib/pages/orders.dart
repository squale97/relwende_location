import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/commande_detail.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:flutter_ecommerce_app/pages/model/commandeModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderPageD extends StatefulWidget {
  const OrderPageD({super.key});

  @override
  State<OrderPageD> createState() => _OrderPageDState();
}

class _OrderPageDState extends State<OrderPageD> {
  DateTime now = DateTime.now();
  bool isVide = false;
  Future<CommandeModel?>? _commandes;
  Future<CommandeModel?> fetchCommandes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Produits> comProds = [];
    //Return double
    int ID = prefs.getInt('ID');
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response;
    try {
      response = await http.post(
        AppUrl.url + "commandeByUser",
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode({"user": ID}),
      );
    } catch (e) {
      return null;
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      //print("ok");
      //  print(response.body.toString());

      /* setState(() {
        for (int i = 0;
            i <=
                CommandeModel.fromJson(jsonDecode(response.body))
                    .contenu!
                    .length;
            i++) {
          for (int j = 0;
              j <=
                  CommandeModel.fromJson(jsonDecode(response.body))
                      .contenu![i]
                      .produits!
                      .length;
              i++) {
            comProds.add(CommandeModel.fromJson(jsonDecode(response.body))
                .contenu![i]
                .produits![j]);
          }
        }
        print(comProds);
        //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      });*/
      // print(ProductByCategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return CommandeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Aucune commande en cours');
    }
  }

  @override
  void initState() {
    // fetchCommandes();
    _commandes = fetchCommandes();
    // TODO: implement initState
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    // Your back press code here...
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  isLoggedin: true,
                )));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff3b22a1),
            title: Text(
              "Commandes",
            ),
          ),
          body: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: FutureBuilder<CommandeModel?>(
                      future: _commandes, //fetchCommandes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.contenu!.isNotEmpty) {
                            return ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount: snapshot
                                    .data!.contenu!.length, //cryptoData.length,
                                itemBuilder: (context, index) {
                                  DateTime? livraisonDate = now;
                                  if (snapshot.data!.contenu![index]
                                          .dateLivraison! !=
                                      "") {
                                    livraisonDate = DateFormat('dd/MM/yyyy')
                                        .parse(snapshot.data!.contenu![index]
                                            .dateLivraison!);
                                  }

                                  if (snapshot.data!.contenu!.length == 0) {
                                    Center(
                                        child:
                                            Text("Aucune commande en cours"));
                                  } else {
                                    return
                                        // Text("Commande 1"),
                                        Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      height: 220,
                                      width: double.maxFinite,
                                      child: InkWell(
                                        onTap: () {
                                          print("clikkkkk");
                                          print(snapshot.data!.contenu![index]
                                              .dateLivraison);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommmandeDetailPage(
                                                        products: snapshot
                                                            .data!
                                                            .contenu![index]
                                                            .produits,
                                                        dateLivraison: snapshot
                                                            .data!
                                                            .contenu![index]
                                                            .dateLivraison,
                                                        id: snapshot
                                                            .data!
                                                            .contenu![index]
                                                            .id!,
                                                      )));
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                              top: BorderSide(
                                                width: 2.0,
                                                color: Colors
                                                    .blue, //cryptoData[index][‘iconColor’]),
                                              ),
                                              //color: Colors.white,
                                            )),
                                            child: Padding(
                                              padding: EdgeInsets.all(7),
                                              child: Stack(children: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 5),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Image.asset(
                                                                    "assets/icons/logo_traite.png",
                                                                    height: 50,
                                                                    width: 50,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    "Commande:" +
                                                                        index
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Spacer(),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(snapshot
                                                                      .data!
                                                                      .contenu![
                                                                          index]
                                                                      .date!),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 150,
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Text("nombre de produits : " +
                                                                      snapshot
                                                                          .data!
                                                                          .contenu![
                                                                              index]
                                                                          .produits!
                                                                          .length
                                                                          .toString())
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              // Text("Total: 20000"),
                                                              SizedBox(
                                                                height: 10,
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data!
                                                                    .contenu![
                                                                        index]
                                                                    .statut!,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              !now.isAfter(
                                                                          livraisonDate) ==
                                                                      true
                                                                  ? Text(
                                                                      "LIvraison prévue le : " +
                                                                          snapshot
                                                                              .data!
                                                                              .contenu![index]
                                                                              .dateLivraison!,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "Livraison prévue le : " +
                                                                          snapshot
                                                                              .data!
                                                                              .contenu![index]
                                                                              .dateLivraison!,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                              Text(
                                                                "Date de livraison souhaitée : " +
                                                                    snapshot
                                                                        .data!
                                                                        .contenu![
                                                                            index]
                                                                        .dateLivraisonSouhaite!,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                "Durée de location : " +
                                                                    snapshot
                                                                        .data!
                                                                        .contenu![
                                                                            index]
                                                                        .dureeLocation!
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                });
                          } else {
                            return Center(
                              child: Text("Aucune commande en cours"),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff3b22a1))),
                        );
                        ;
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
