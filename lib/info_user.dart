import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/Animation/FadeAnimation.dart';
import 'package:flutter_ecommerce_app/account/login.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:flutter_ecommerce_app/pages/model/user_model.dart';
import 'package:flutter_ecommerce_app/pages/update_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'appUrl.dart';

class InfoUserPage extends StatefulWidget {
  //const InfoUserPage({super.key});
  bool? isLoggedIn;
  InfoUserPage({this.isLoggedIn});

  @override
  State<InfoUserPage> createState() => _InfoUserPageState();
}

class _InfoUserPageState extends State<InfoUserPage> {
  Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return double
    int ID = prefs.getInt('ID');
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.post(
      AppUrl.url + "userById",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
      body: jsonEncode({"id": ID}),
    );
    if (response.statusCode == 200) {
      setState(() {
        name = UserModel.fromJson(jsonDecode(response.body)).contenu![0].nom;
        bio = UserModel.fromJson(jsonDecode(response.body)).contenu![0].prenom;
        tel = UserModel.fromJson(jsonDecode(response.body)).contenu![0].contact;
        email = UserModel.fromJson(jsonDecode(response.body)).contenu![0].email;
        if (email == "") {
          email = "non renseigné";
        }
      });
      //print("ok");
      //  print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(ProductByCategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Panier');
    }
  }

  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  String? name = '';
  String? bio = '';
  String? tel = '';
  String? profileImage = 'assets/icons/logo_tratie.png';
  String? email = '';
  @override
  Widget build(BuildContext context) {
    if (widget.isLoggedIn == true) {
      return Scaffold(
        /*bottomSheet: Container(
            //alignment: Alignment.bottomCenter,
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
            child: Text("RelwendeLocations ® 2023")),*/
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                color: Color(0xff3b22a1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/icons/logo_traite.png"), //AssetImage(profileImage!),
                      radius: 50.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      name! + " " + bio!,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            /*Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              bio!,
              style: TextStyle(fontSize: 16.0),
            ),
          ),*/
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Informations',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
                child: Card(
              //color: Colors.grey[300],
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(tel!),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(email!),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(name!),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(bio!),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                      1.7,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateUserPage(
                                          nom: name,
                                          prenom: bio,
                                          email: email,
                                          num: tel,
                                        )));
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "Modifier",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          // barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Alert"),
                              content: Text(
                                  "Etes vous sur de vouloir supprimer votre compte définitivement? vous perdrez toutes les infos de panier et de commande"),
                              actions: <Widget>[
                                MaterialButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      //Return double
                                      int ID = prefs.getInt('ID');
                                      String username = '54007038';
                                      String password = '2885351';
                                      String basicAuth =
                                          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
                                      final response;
                                      try {
                                        response = await http.post(
                                            Uri.parse(
                                              AppUrl.url + 'delete/user',
                                            ),
                                            headers: <String, String>{
                                              'authorization': basicAuth,
                                              'Content-Type':
                                                  'application/json; charset=UTF-8'
                                            },
                                            body: jsonEncode({"id": ID}));
                                      } catch (e) {
                                        //print(e);
                                        return null;
                                      }
                                      // print(response.statusCode);
                                      if (response.statusCode == 200) {
                                        prefs.setString('number', null);
                                        prefs.setInt('ID', null);

                                        print("compte supprimé");

                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.info,
                                          text: 'Votre compte a été supprime',
                                        );

                                        Timer(Duration(seconds: 3), () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(
                                                        isLoggedin: false,
                                                      )),
                                              (Route<dynamic> route) => false);
                                          // print("Yeah, this line is printed after 3 seconds");
                                        });
                                      }
                                      // print("ok");
                                      // print(object)

                                      /*Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginPage()));*/
                                    },
                                    child: Text("oui")),
                                MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      /*Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginPage()));*/
                                    },
                                    child: Text("annuler"))
                              ],
                            );
                          });
                    },
                    child: Text("Supprimer mon compte"),
                  )
                ],
              ),
            ) /* ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Post $index',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                );
              },
            ),*/
                ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
            child: AlertDialog(
          title: Text("Alert"),
          content: Text("Vous devez vous connecter au préalable"),
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  //Navigator.of(context).pop();v
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                isLoggedin: false,
                              )));
                  /*Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginPage()));*/
                },
                child: Text("ok"))
          ],
        )),
      );
    }
  }
}
