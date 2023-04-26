import 'dart:convert';
import 'package:flutter_ecommerce_app/pages/commande_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/model/commandeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  // final List<Order> orders;

  // OrderPage({required this.orders});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<CommandeModel> fetchCommandes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return double
    int ID = prefs.getInt('ID');
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.post(
      AppUrl.url + "commandeByUser",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
      body: jsonEncode({"user": ID}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      //print("ok");
      //  print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(ProductByCategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return CommandeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Panier');
    }
  }

  List orders = [
    {
      "orderId": 1,
      "totalAmount": 200,
      "orderTime": new DateTime(2017, 9, 7, 17, 30)
    },
    {
      "orderId": 1,
      "totalAmount": 200,
      "orderTime": new DateTime(2017, 9, 7, 17, 30)
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3b22a1),
          title: Text('Mes Commandes'),
        ),
        body: FutureBuilder<CommandeModel>(
            future: fetchCommandes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.contenu!.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Order order = orders[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xff3b22a1),
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(
                          'commande ' + snapshot.data!.contenu![index].libele!),
                      subtitle: Text(
                          'statut: ' + snapshot.data!.contenu![index].statut!),
                      trailing:
                          Text(snapshot.data!.contenu![index].dateEvenement!),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommmandeDetailPage(
                                      products: snapshot
                                          .data!.contenu![index].produits,
                                    )));
                        // TODO: Navigate to order detail page
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class Order {
  final int orderId;
  final double totalAmount;
  final DateTime orderDate;

  Order({
    required this.orderId,
    required this.totalAmount,
    required this.orderDate,
  });
}
