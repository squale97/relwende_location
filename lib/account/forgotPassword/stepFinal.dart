import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../appUrl.dart';

class StepFinalPage extends StatefulWidget {
  const StepFinalPage({super.key});

  @override
  State<StepFinalPage> createState() => _StepFinalPageState();
}

class _StepFinalPageState extends State<StepFinalPage> {
  TextEditingController _numEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réinitialisation de mot de passe"),
        backgroundColor: Color(0xff3b22a1),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
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
                      borderSide:
                          BorderSide(width: 2, color: Colors.white // isDarkMode
                              // ? Colors.white
                              // : Colors.black,
                              ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400)),
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
                height: 40,
              ),
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
                      borderSide:
                          BorderSide(width: 2, color: Colors.white // isDarkMode
                              // ? Colors.white
                              // : Colors.black,
                              ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400)),
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
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
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
                          borderSide: BorderSide(color: Colors.grey.shade400)),
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
              ),
              SizedBox(
                height: 40,
              ),
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
                                /* final response;
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
                                if (response.statusCode == 200) {}*/
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
          ),
        ),
      ),
    );
  }
}
