import 'dart:async';
import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_ecommerce_app/account/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../appUrl.dart';

class StepFinalPage extends StatefulWidget {
  String? tel;
  StepFinalPage({this.tel});

  @override
  State<StepFinalPage> createState() => _StepFinalPageState();
}

class _StepFinalPageState extends State<StepFinalPage> {
  TextEditingController _numEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _confirmEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _text = '';
  bool _isObscure = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

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
                enabled: false,
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
                controller: _numEditingController..text = widget.tel!,
                // obscureText: true,
                decoration: InputDecoration(

                    // focusColor: Colors.orange,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          width: 2, color: Colors.white // isDarkMode
                          // ? Colors.whiteTextEditingController _numEditingController = TextEditingController();
                          // : Colors.black,
                          ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Numéro de téléphone',
                    //hintText
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Numero de téléphone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "telephone"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                obscureText: _isObscure,
                onChanged: (value) {
                  setState(() {
                    _text = value;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  // FilteringTextInputFormatter.digitsOnly
                ],
                style: TextStyle(color: Colors.black),
                controller: _passwordEditingController,
                // obscureText: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: Color(0xff3b22a1),
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _toggleObscure,
                    ),
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
                    labelText: 'Mot de passe',
                    //hintText
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Mot de passe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Mot de passe"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
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
                  obscureText: _isObscure,
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    //FilteringTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(color: Colors.black),
                  controller: _confirmEditingController,
                  // obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: Color(0xff3b22a1),
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: _toggleObscure,
                      ),
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
                      labelText: 'Confirmation de mot de passe',
                      //hintText
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Confirmation de mot de passe'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        _passwordEditingController.text !=
                            _confirmEditingController.text) {
                      return "Veuillez confirmer le mot de passe";
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
                              /* ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  dismissDirection: DismissDirection.up,
                                  duration: Duration(seconds: 3),
                                  content: Text(
                                    "mot de passe modifié",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              );*/

                              /*showDialog(
                                  // barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Column(children: [
                                        Text("Succès"),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 75,
                                        )
                                      ]),
                                      content: Text(
                                          "Mot de passe modifier avec succès"),
                                      actions: <Widget>[
                                        /*MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              /*Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginPage()));*/
                                            },
                                            child: Text("ok"))*/
                                      ],
                                    );
                                  });*/
                              /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));*/
                              //print(_formKey.currentState!.validate());
                              //if (AppResponsive.isMobile(context)){print("mobile");}else print("non mobile");
                              String username = "54007038";
                              String password = "2885351";
                              print("clicked");
                              String basicAuth = 'Basic ' +
                                  base64Encode(
                                      utf8.encode('$username:$password'));

                              if (_formKey.currentState!.validate()) {
                                print(widget.tel);
                                final response;
                                try {
                                  response = await http.post(
                                      Uri.parse(
                                        AppUrl.url + 'update/user/password',
                                      ),
                                      headers: <String, String>{
                                        'authorization': basicAuth,
                                        'Content-Type':
                                            'application/json; charset=UTF-8'
                                      },
                                      body: jsonEncode({
                                        "telephone": widget.tel,
                                        "password":
                                            _passwordEditingController.text
                                      }));
                                } catch (e) {
                                  return null;
                                }
                                print(response.statusCode);
                                if (response.statusCode == 200) {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      text: 'Mot de passe modifié',
                                      onConfirmBtnTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      }
                                      //autoCloseDuration: const Duration(seconds: 2),
                                      );
                                  Timer(Duration(seconds: 3), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                    // print("Yeah, this line is printed after 3 seconds");
                                  });
                                  /* showDialog(
                                      // barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(children: [
                                            Text("Succès"),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: 75,
                                            )
                                          ]),
                                          content:
                                              Text("identifiants invalides"),
                                          actions: <Widget>[
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
                                                child: Text("ok"))
                                          ],
                                        );
                                      });*/
                                } else {
                                  showDialog(
                                      // barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Alert"),
                                          content: Text("Erreur réessayer"),
                                          actions: <Widget>[
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
                                                child: Text("ok"))
                                          ],
                                        );
                                      });

                                  Timer(Duration(seconds: 3), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                    // print("Yeah, this line is printed after 3 seconds");
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
