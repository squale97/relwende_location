import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/account/login.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _prenomEditingController = TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _numTelEditingController = TextEditingController();
  TextEditingController _numEditingController = TextEditingController();
  TextEditingController _confirmPasswordEditingController =
      TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _codePinEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff3b22a1),
        title: Text("Création de compte"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 35),
              Image.asset(
                "assets/icons/logo_traite.png",
                height: 200,
                width: 200,
                //style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 25,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(children: [
                        const SizedBox(
                          width: 15,
                        ),
                        // Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        Flexible(
                          child: TextFormField(
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            inputFormatters: [
                              //  FilteringTextInputFormatter.deny(RegExp("[ ]"))
                            ],
                            controller: _nameEditingController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                focusColor: Color(0xff3b22a1),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                labelText: 'nom',
                                labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                hintText: 'nom'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez entrer le nom utilisateur";
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(
                          width: 15,
                        ),

                        //Padding(
                        //padding: const EdgeInsets.only(
                        //left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        //child:
                        Flexible(
                          child: TextFormField(
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            inputFormatters: [
                              //FilteringTextInputFormatter.deny(RegExp("[ ]"))
                            ],
                            controller: _prenomEditingController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              // focusColor: Colors.orange,
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              labelText: "Prénom",
                              labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez entrer votre prénom";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp("[ ]"))
                          ],
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.mail,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              // focusColor: Colors.orange,
                              enabledBorder: UnderlineInputBorder(
                                //borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              labelText: 'adresse email (optionnel)',
                              labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                              hintText: 'Optionnel'),

                          /* validator: (value) {
                                 if (value == null || value.isEmpty) {
                                      return "Veuillez entrer votre email";
                                 }
                                 return null;
                               },*/
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp("[ ]")),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _numTelEditingController,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              // focusColor: Colors.orange,
                              enabledBorder: UnderlineInputBorder(
                                //borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              labelText: 'numéro de téléphone',
                              labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                              hintText: 'numéro de téléphone'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer votre prénom";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp("[ ]"))
                          ],
                          controller: _passwordEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              // focusColor: Colors.orange,
                              enabledBorder: UnderlineInputBorder(
                                //borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              labelText: 'mot de passe',
                              labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                              hintText: 'mot de passe '),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer votre mot de passe";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp("[ ]"))
                          ],
                          controller: _confirmPasswordEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              // focusColor: Colors.orange,
                              enabledBorder: UnderlineInputBorder(
                                //borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              labelText: 'confirmation de mot de passe',
                              labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                              hintText: 'confirmation de mot de passe'),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                _passwordEditingController.text !=
                                    _confirmPasswordEditingController.text) {
                              return "Veuillez confirmer le mot de passe";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      /* Container(
              height: 50,
              width: 250,
              
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(250)
             
              ),
             // decoration: BoxDecoration(
                  //color: Colors.orange, borderRadius: BorderRadius.circular(20),
                  //border:Border.all(),
                  //),
                  
              child: ElevatedButton(
                //color: Colors.orange,
                onPressed: () {},
                child: Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),*/
                      const SizedBox(height: 30),
                      MaterialButton(
                        height: 50,
                        minWidth: 300,
                        //minWidth: double.infinity,
                        //height:60,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String username = "54007038";
                            String password = "2885351";
                            print("clicked");
                            String basicAuth = 'Basic ' +
                                base64Encode(
                                    utf8.encode('$username:$password'));

                            // if (_passwordEditingController.text!=_confirmPasswordEditingController.text){_formKey.currentState!.deactivate();}
                            final response = await http.post(
                                Uri.parse(
                                  AppUrl.url + 'userRegister',
                                ),
                                headers: <String, String>{
                                  HttpHeaders.authorizationHeader: basicAuth,
                                  'Content-Type':
                                      'application/json; charset=UTF-8'
                                },
                                body: jsonEncode(<String, String>{
                                  "nom": _nameEditingController.text,
                                  "prenom": _prenomEditingController.text,
                                  "email": _emailEditingController.text,
                                  "contact": _numTelEditingController.text,
                                  // "num_cnib": _numEditingController.text,
                                  "password": _passwordEditingController.text,
                                  // "code_pin": _codePinEditingController.text,
                                }));
                            print(response.statusCode);
                            if (response.statusCode == 200) {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text:
                                    'Votre compte a été créé: veuillez vous connecter!',
                                autoCloseDuration: const Duration(seconds: 4),
                              );
                              /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                          // isLoggedin: true,
                                          //solde: 0,
                                          //  numTelephone:
                                          // _numTelEditingController.text,
                                          )));*/
                            }
                          }
                        },
                        color: Color(0xff3b22a1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous avez déja un compte?",
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  "Connectez vous",
                                  style: TextStyle(color: Color(0xff3b22a1)),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                          ])
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}