/*import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/pages/cart/components/cart_card.dart';
import 'package:flutter_ecommerce_app/pages/model/cartModel.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/panierModel.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  bool? isLoggedIn;

  CartScreen({this.isLoggedIn});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isloading = false;
  num? totalPrice = 0;
  int testItem = 1;
  late List<Produits> _products;
  late List<bool> _selected = [];
  List<Produits> confirmProducts = [];
  Future<PanierModel>? _panier;
  Future<PanierModel> fetchPanier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return double
    int ID = prefs.getInt('ID');
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.post(
      AppUrl.url + "panierByUser",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
      body: jsonEncode({"clientId": ID}),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        totalPrice =
            PanierModel.fromJson(jsonDecode(response.body)).contenu![0].total!;
        _products = PanierModel.fromJson(jsonDecode(response.body))
            .contenu![0]
            .produits!;
        int i;
        for (i = 1;
            i <
                PanierModel.fromJson(jsonDecode(response.body))
                        .contenu![0]
                        .produits!
                        .length +
                    1;
            i++) {
          //bool a = false;
          _selected.add(false);
        }
        print(PanierModel.fromJson(jsonDecode(response.body))
            .contenu![0]
            .produits!
            .length);
        print(_selected);
        //print(_products[0].prix);
        // print("taille :" + counter.toString());
      });
      //print("ok");
      //  print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(ProductByCategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return PanierModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Panier');
    }
  }

  String date = "";
  DateTime selectedDate = DateTime.now();
  DateTime _date = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  _handleDatePickerEvenement() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      _date = date;
    }
    _dateEvenementController.text = _dateFormat.format(date!);
    //_clotureDateEditingController.text = _dateFormat.format(date);
  }

  _handleDatePickerLivraison() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      _date = date;
    }
    _dateLivraisonController.text = _dateFormat.format(date!);
    //_clotureDateEditingController.text = _dateFormat.format(date);
  }

  /* _handleDatePicker2() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      _date = date;
    }
    //_distriDateEditingController.text = _dateFormat.format(date);
    _clotureDateEditingController.text = _dateFormat.format(date);
  }
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _panier = fetchPanier();
  }

  // bool value = false;
  @override
  Widget build(BuildContext context) {
    if (widget.isLoggedIn == true) {
      return Stack(children: [
        Scaffold(
            appBar: buildAppBar(context),
            body: FutureBuilder<PanierModel>(
                future: _panier, //fetchPanier(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemCount:
                            _products //snapshot.data!.contenu![0].produits!
                                .length, //demoCarts.length,
                        itemBuilder: (context, index) {
                          bool value = false;
                          final product_title = snapshot
                              .data!.contenu![0].produits![index].libele!;
                          final product_id =
                              snapshot.data!.contenu![0].produits![index].id;
                          int? nbreItems =
                              snapshot.data!.contenu![0].produits![index].index;
                          num itemsN = nbreItems!;
                          final price =
                              snapshot.data!.contenu![0].produits![index].prix;
                          final total = snapshot.data!.contenu![0].total;
                          // setState(() {
                          testItem = _products[index].index; //nbreItems!;
                          // });
                          totalPrice = total!;
                          bool isChecked = false;

                          int? testNum = nbreItems;
                          return Card(
                            color: Colors.grey[300],
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Dismissible(
                                key:
                                    Key(demoCarts[index].product.id.toString()),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  setState(() {
                                    demoCarts.removeAt(index);
                                  });
                                },
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFE6E6),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      //SvgPicture.asset("assets/icons/Trash.svg"),
                                    ],
                                  ),
                                ),
                                //child: //Card(
                                //color: Colors.grey[300],
                                child: CheckboxListTile(
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _toggleProductSelection(index);
                                      _products[index].isChecked = value!;

                                      // value = _products[index].isChecked;
                                      //print(confirmProducts);
                                    });
                                  },
                                  value: _selected[index],
                                  //leading
                                  secondary: Wrap(
                                      spacing: 12, // space between two icons
                                      children: <Widget>[
                                        //Che
                                        Image.network(
                                          AppUrl.url +
                                              "produitImages/" +
                                              product_id.toString(),
                                          width: 75,
                                          height: 75,
                                        ),
                                      ]),
                                  title: Column(children: [
                                    Text(
                                      product_title,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "$price frs",
                                      // "x" +
                                      //nbreItems
                                      //  .toString(), //"\$${cart.product.price}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        //fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                                  subtitle: Column(
                                    children: [
                                      /*Text(
                                        price.toString(),
                                        // "x" +
                                        //nbreItems
                                        //  .toString(), //"\$${cart.product.price}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          //fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),*/
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                isloading = true;
                                              });

                                              Timer.periodic(
                                                  const Duration(seconds: 5),
                                                  (t) {
                                                setState(() {
                                                  isloading =
                                                      false; //set loading to false
                                                });
                                                t.cancel(); //stops the timer
                                              });

                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              //Return double
                                              int ID = prefs.getInt('ID');
                                              String username = '54007038';
                                              String password = '2885351';
                                              String basicAuth =
                                                  'Basic ${base64Encode(utf8.encode('$username:$password'))}';

                                              final response = await http.post(
                                                AppUrl.url +
                                                    "cart/product/decrement",
                                                headers: {
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                  'authorization': basicAuth
                                                },
                                                body: jsonEncode({
                                                  "user": ID,
                                                  "product": product_id
                                                }),
                                              );
                                              if (response.statusCode == 200) {
                                                setState(() {
                                                  isloading = false;
                                                });
                                                setState(() {
                                                  if (nbreItems! > 1) {
                                                    print("ok");
                                                    itemsN--;
                                                    _products[index].index--;
                                                    _panier =
                                                        fetchPanier(); //fetchPanier();
                                                    //nbreItems = nbreItems! - 1;
                                                    //print()
                                                  }
                                                });

                                                //fetchPanier();
                                                print("décrémenté");
                                              }
                                            },
                                            icon: Icon(Icons.remove),
                                          ),
                                          Text(_products[index]
                                              .index
                                              .toString()),
                                          // Text('${itemsN}'),
                                          IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                isloading = true;
                                              });

                                              Timer.periodic(
                                                  const Duration(seconds: 5),
                                                  (t) {
                                                setState(() {
                                                  isloading =
                                                      false; //set loading to false
                                                });
                                                t.cancel(); //stops the timer
                                              });

                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              //Return double
                                              int ID = prefs.getInt('ID');
                                              String username = '54007038';
                                              String password = '2885351';
                                              String basicAuth =
                                                  'Basic ${base64Encode(utf8.encode('$username:$password'))}';

                                              final response = await http.post(
                                                AppUrl.url +
                                                    "cart/product/increment",
                                                headers: {
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                  'authorization': basicAuth
                                                },
                                                body: jsonEncode({
                                                  "user": ID,
                                                  "product": product_id
                                                }),
                                              );
                                              //  setState(() {
                                              //nbreItems = nbreItems! + 1;
                                              //});
                                              if (response.statusCode == 200) {
                                                setState(() {
                                                  isloading = false;
                                                  _products[index].index++;
                                                  _panier = fetchPanier();
                                                  //fetchPanier();
                                                });
                                              }
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  /* trailing: Checkbox(
                                    value: _products[index].isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _products[index].isChecked = value!;
                                        // _products[index].index = value! ? 1 : 0;
                                      });
                                    },
                                  ),*/
                                  /*Wrap(
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            testItem = testItem;
                                            // nbreItems++; //= nbreItems! - 1;
                                          });
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                          
                                          //Return double
                                          int ID = prefs.getInt('ID');
                                          String username = '54007038';
                                          String password = '2885351';
                                          String basicAuth =
                                              'Basic ${base64Encode(utf8.encode('$username:$password'))}';
                          
                                          final response = await http.post(
                                            AppUrl.url + "cart/product/decrement",
                                            headers: {
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'authorization': basicAuth
                                            },
                                            body: jsonEncode({
                                              "user": ID,
                                              "product": product_id
                                            }),
                                          );
                                          if (response.statusCode == 200) {
                                            //fetchPanier();
                                            print("incrémenté");
                                          }
                                        },
                                        //backgroundColor: Colors.grey,
                                        child: Image.asset(
                                          "assets/icons/minus.png",
                                          //  onPressed: () {},
                                          ////icon: Text('-'),
                                          //iconSize: 25,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ), // icon-1
                                      //Icon(Icons.message),
                                      Text(
                                          nbreItems
                                              .toString(), //" x${cart.numOfItem}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            nbreItems = nbreItems! + 1;
                                          });
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                          
                                          //Return double
                                          int ID = prefs.getInt('ID');
                                          String username = '54007038';
                                          String password = '2885351';
                                          String basicAuth =
                                              'Basic ${base64Encode(utf8.encode('$username:$password'))}';
                          
                                          final response = await http.post(
                                            AppUrl.url + "cart/product/increment",
                                            headers: {
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'authorization': basicAuth
                                            },
                                            body: jsonEncode({
                                              "user": ID,
                                              "product": product_id
                                            }),
                                          );
                                          //  setState(() {
                                          //nbreItems = nbreItems! + 1;
                                          //});
                                          if (response.statusCode == 200) {
                                            print("incrémenté");
                                          }
                                        },
                                        //backgroundColor: Colors.grey,
                                        child: Image.asset(
                                          "assets/icons/plus.png",
                                          //  onPressed: () {},
                                          ////icon: Text('-'),
                                          //iconSize: 25,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      /* IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.check_box))*/
                                    ],
                                  )*/
                                  // icon-2
                                ),
                              ),

                              /*Row(
                                    children: [
                                      SizedBox(
                                        width: 88,
                                        child: AspectRatio(
                                          aspectRatio: 0.88,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF5F6F9),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Image.network(AppUrl.url +
                                                "produitImages/" +
                                                product_id.toString()),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product_title,
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16),
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 10),
                                          Text.rich(
                                            TextSpan(
                                              text: price
                                                  .toString(), //"\$${cart.product.price}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                //fontSize: size.height * 0.02,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: "x" +
                                                        nbreItems
                                                            .toString(), //" x${cart.numOfItem}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                
                                          //Return double
                                          int ID = prefs.getInt('ID');
                                          String username = '54007038';
                                          String password = '2885351';
                                          String basicAuth =
                                              'Basic ${base64Encode(utf8.encode('$username:$password'))}';
                                
                                          final response = await http.post(
                                            AppUrl.url + "cart/product/decrement",
                                            headers: {
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'authorization': basicAuth
                                            },
                                            body: jsonEncode({
                                              "user": ID,
                                              "product": product_id
                                            }),
                                          );
                                          if (response.statusCode == 200) {
                                            print("incrémenté");
                                            setState(() {
                                              nbreItems = nbreItems! - 1;
                                            });
                                          }
                                        },
                                        //backgroundColor: Colors.grey,
                                        child: Image.asset(
                                          "assets/icons/minus.png",
                                          //  onPressed: () {},
                                          ////icon: Text('-'),
                                          //iconSize: 25,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(nbreItems.toString()),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                
                                          //Return double
                                          int ID = prefs.getInt('ID');
                                          String username = '54007038';
                                          String password = '2885351';
                                          String basicAuth =
                                              'Basic ${base64Encode(utf8.encode('$username:$password'))}';
                                
                                          final response = await http.post(
                                            AppUrl.url + "cart/product/increment",
                                            headers: {
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'authorization': basicAuth
                                            },
                                            body: jsonEncode({
                                              "user": ID,
                                              "product": product_id
                                            }),
                                          );
                                          //  setState(() {
                                          //nbreItems = nbreItems! + 1;
                                          //});
                                          if (response.statusCode == 200) {
                                            setState(() {
                                              nbreItems = nbreItems! + 1;
                                            });
                                            print("incrémenté");
                                          }
                                        },
                                        //backgroundColor: Colors.grey,
                                        child: Image.asset(
                                          "assets/icons/plus.png",
                                          //  onPressed: () {},
                                          ////icon: Text('-'),
                                          //iconSize: 25,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.check_box),
                                        onPressed: () {},
                                      )
                                    ],
                                  ) */ //CartCard(cart: demoCarts[index]),
                              //),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Center(
                    child: SizedBox(),
                  );
                }),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 30,
              ),
              // height: 174,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -15),
                    blurRadius: 20,
                    color: Color(0xFFDADADA).withOpacity(0.15),
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/icons/logo_traite.png"),
                        ),
                        Spacer(),
                        Text("Ajouter un code promo"),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kTextColor,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text: totalPrice.toString() + " FCFA",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16, //size.height * 0.02,
                                  fontWeight: FontWeight.bold,
                                ), //"\$337.15",
                                //style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: TextButton(
                            child: Text(
                              "Commander",
                              style: TextStyle(
                                  color: Color(0xff3b22a1), fontSize: 16),
                            ),
                            onPressed: () {
                              if (confirmProducts.isEmpty) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: 'Aucun article sélectionné!',
                                  autoCloseDuration: const Duration(seconds: 2),
                                );
                              } else {
                                showInformationDialog(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ) //CheckoutCard(),
            ),
        if (isloading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isloading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ]);
    } else {
      return Scaffold(
        body: Center(
          child: Text("Veuillez vous connecter au préalable"),
        ),
      );
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff3b22a1),
      title: Column(
        children: [
          Text(
            "Panier",
            style: TextStyle(color: Colors.white),
          ),
          /* Text(
            "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),*/
        ],
      ),
    );
  }

  void _toggleProductSelection(int index) {
    setState(() {
      _selected[index] = !_selected[index];
      if (_selected[index]) {
        confirmProducts.add(_products[index]);
      } else {
        confirmProducts.removeWhere((product) => product == _products[index]);
      }
      print(confirmProducts);
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dureController = TextEditingController();
  final TextEditingController _dateLivraisonController =
      TextEditingController();
  final TextEditingController _dateEvenementController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          onTap: _handleDatePickerLivraison,
                          controller: _dateLivraisonController,
                          validator: (value) {
                            return value!.isNotEmpty
                                ? null
                                : "Date de livraison";
                          },
                          decoration:
                              InputDecoration(hintText: "Date de livraison"),
                        ),
                        TextFormField(
                          onTap: _handleDatePickerEvenement,
                          controller: _dateEvenementController,
                          validator: (value) {
                            return value!.isNotEmpty
                                ? null
                                : "Date de l'évènement";
                          },
                          decoration:
                              InputDecoration(hintText: "Date evenement"),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _dureController,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Durée";
                          },
                          decoration: InputDecoration(hintText: "Durée"),
                        ),
                        TextFormField(
                          controller: _addressController,
                          validator: (value) {
                            return value!.isNotEmpty
                                ? null
                                : "Addresse de livraison";
                          },
                          decoration: InputDecoration(
                              hintText: "Addresse de livraison"),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              child: Text('Valider'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Do something like updating SharedPreferences or User Settings etc.

                                  //  final response = await http.postSharedPreferences prefs = await SharedPreferences.getInstance();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  //Return double
                                  int ID = prefs.getInt('ID');
                                  String username = '54007038';
                                  String password = '2885351';
                                  String basicAuth =
                                      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

                                  final response = await http.post(
                                    AppUrl.url + "panierByUser",
                                    headers: {
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                      'authorization': basicAuth
                                    },
                                    body: jsonEncode({"clientId": ID}),
                                  );
                                  print(response.statusCode);

                                  if (response.statusCode == 200) {}
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                            MaterialButton(
                              child: Text('Annuler'),
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                // Do something like updating SharedPreferences or User Settings etc.
                                Navigator.of(context).pop();
                                //}
                              },
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              title: Text('Confirmer la commande'),
              actions: <Widget>[
                /*  MaterialButton(
                  child: Text('Valider'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
                SizedBox(
                  width: 150,
                ),
                MaterialButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),*/
              ],
            );
          });
        });
  }
}

class Product {
  int id;
  String description;
  String extend;
  int index;
  String libele;
  num prix;
  String reference;
  int stock;
  String couleur;
  int categorie;

  Product(
      {required this.libele,
      required this.description,
      required this.extend,
      required this.couleur,
      required this.prix,
      required this.index,
      required this.reference,
      required this.stock,
      required this.categorie,
      required this.id});
}
*/