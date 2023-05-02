import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/account/forgotPassword/step2.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:http/http.dart' as http;

class Forgot_Step1Page extends StatefulWidget {
  const Forgot_Step1Page({super.key});

  @override
  State<Forgot_Step1Page> createState() => _Forgot_Step1PageState();
}

class _Forgot_Step1PageState extends State<Forgot_Step1Page> {
  TextEditingController _numEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _text = '';
  String? numero;
  @override
  void initState() {
    print(_numEditingController.text);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information de compte"),
        backgroundColor: Color(0xff3b22a1),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "Réinitialiser votre mot de passe",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Entrer votre numéro de télephone lié au compte"),
          SizedBox(
            height: 50,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(color: Colors.black),
                    controller: _numEditingController,
                    // obscureText: true,
                    decoration: InputDecoration(

                        // focusColor: Colors.orange,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              width: 2, color: Colors.white // isDarkMode
                              // ? Colors.white
                              // : Colors.black,
                              ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        //labelText: 'Numéro de téléphone',
                        //hintText
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Numero de téléphone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "password"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //_formKey.currentState!.validate() == truen

                  Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InkWell(
                          onTap: _text == null || _text == ''
                              ? null
                              : () async {
                                  //print(_formKey.currentState!.validate());
                                  //if (AppResponsive.isMobile(context)){print("mobile");}else print("non mobile");
                                  String username = "54007038";
                                  String password = "2885351";
                                  print("clicked");
                                  String basicAuth = 'Basic ' +
                                      base64Encode(
                                          utf8.encode('$username:$password'));

                                  if (_formKey.currentState!.validate()) {
                                    final response;
                                    try {
                                      response = await http.post(
                                          Uri.parse(
                                            AppUrl.url + 'getcode',
                                          ),
                                          headers: <String, String>{
                                            'authorization': basicAuth,
                                            'Content-Type':
                                                'application/json; charset=UTF-8'
                                          },
                                          body: jsonEncode({
                                            "telephone":
                                                _numEditingController.text,
                                          }));
                                    } catch (e) {
                                      return null;
                                    }
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      numero = _numEditingController.text;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white,
                                          content: Text(
                                            "Un code a été envoyé a été envoyé à votre numéro !",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green),
                                          ),
                                        ),
                                      );

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Forgot_Step2Page(
                                                    numTel: numero,
                                                  )));
                                      _numEditingController.text = "";
                                    } else {
                                      showDialog(
                                          // barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Alert"),
                                              content: Text(
                                                  "Vérifier votre numéro de télephone et reéssayer"),
                                              actions: <Widget>[
                                                MaterialButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      /*Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginPage()));*/
                                                    },
                                                    child: Text("ok"))
                                              ],
                                            );
                                          });
                                    }
                                  }
                                },
                          child: Container(
                            //color: Colors.red,
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: _text != null && _text!.isNotEmpty
                                    ? Color(0xff3b22a1)
                                    : Colors.grey[300], //Color(0xff3b22a1),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "Confirmer",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )))
                ],
              ))
        ],
      ),
    );
  }
}
