import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/account/forgotPassword/stepFinal.dart';
import 'package:flutter_ecommerce_app/account/login.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:http/http.dart' as http;

class Forgot_Step2Page extends StatefulWidget {
  Forgot_Step2Page({this.numTel});
  String? numTel;
  @override
  State<Forgot_Step2Page> createState() => _Forgot_Step2PageState();
}

class _Forgot_Step2PageState extends State<Forgot_Step2Page> {
  TextEditingController _codeEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _text = '';
  @override
  void initState() {
    print(widget.numTel);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code secret"),
        backgroundColor: Color(0xff3b22a1),
      ),
      body: Column(children: [
        SizedBox(
          height: 40,
          width: 40,
        ),
        Center(
            child: Text(
          "       Entrer le code envoyé sur votre numéro de téléphone",
          style: TextStyle(fontSize: 20),
        )),
        SizedBox(
          height: 20,
        ),
        Text(
            "Nous vous avons envoyé un code sur votre numéro de telephone; veuillez l'inscrire dans la case"),
        SizedBox(
          height: 20,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(color: Colors.black),
                    controller: _codeEditingController,
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
                        hintText: 'code'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "code"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                      }
                      return null;
                    },
                  ),
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
                                print(widget.numTel);
                                print(_codeEditingController.text);
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
                                          AppUrl.url + 'validecode',
                                        ),
                                        headers: <String, String>{
                                          'authorization': basicAuth,
                                          'Content-Type':
                                              'application/json; charset=UTF-8'
                                        },
                                        body: jsonEncode({
                                          "telephone": widget.numTel,
                                          "code": _codeEditingController.text
                                        }));
                                  } catch (e) {
                                    return null;
                                  }
                                  print(response.statusCode);
                                  if (response.statusCode == 200) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StepFinalPage(
                                                  tel: widget.numTel,
                                                )));
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
                              "Valider",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )))
              ],
            )),
        TextButton(
          child: Text('Renvoyer le code'),
          onPressed: () async {
            String username = "54007038";
            String password = "2885351";
            print("clicked");
            String basicAuth =
                'Basic ' + base64Encode(utf8.encode('$username:$password'));

            // if (_formKey.currentState!.validate()) {
            final response;
            try {
              response = await http.post(
                  Uri.parse(
                    AppUrl.url + 'getcode',
                  ),
                  headers: <String, String>{
                    'authorization': basicAuth,
                    'Content-Type': 'application/json; charset=UTF-8'
                  },
                  body: jsonEncode({"telephone": widget.numTel}));
            } catch (e) {
              return null;
            }
            if (response.statusCode == 200) {
              print("code renvoyé");
              CoolAlert.show(
                context: context,
                type: CoolAlertType.info,
                text: 'Code envoyé',
                autoCloseDuration: const Duration(seconds: 2),
              );
            } else {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                text: 'Erreur',
                autoCloseDuration: const Duration(seconds: 2),
              );
            }
          },
        )
      ]),
    );
  }
}
