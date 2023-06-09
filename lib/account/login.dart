import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/Animation/FadeAnimation.dart';
import 'package:flutter_ecommerce_app/account/forgotPassword/step1.dart';
import 'package:flutter_ecommerce_app/account/signup.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/admin/admin_home.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/model/loginModel.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({ Key? key }) : super(key: key);

  //LoginPage({});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  String number = '';
  int? ID;
  bool _isObscure = true;
  String? _text;
  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  String? indic;
  Future<Null> loginUser(int? id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('number', _nameEditingController.text);
    prefs.setInt('ID', id);
    setState(() {
      number = _nameEditingController.text;
      ID = id;
      isLoggedIn = true;
    });

    _nameEditingController.clear();
  }

  late String lang;
//AnimationController controller;
  //Animation<double> animation;

  late String dropdownvalue = 'Français';
  // List of items in our dropdown menu
  var items = [
    'English',
    'Français',
  ];

  late String orgName;
  late String siteWeb;
  late String cpName;
  final _nameEditingController = TextEditingController();
  final _urlEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _chosenValue;
  String dropdownValue = 'client';

  @override
  void initState() {
    loading = false;
    //var url = window.location.href;
    //print(url);
    //print("l'URL est"+Uri.base.path);

    print(dropdownvalue);

    super.initState();

    //controller = AnimationController(
    //duration: const Duration(milliseconds: 2000),vsync: this);
    //animation = Tween(begin: 0.0, end: 1.0).animate(controller)
    //..addListener(() {
    //  setState(() {
    // the state that has changed here is the animation object’s value
    // });
    //});
    //controller.repeat();
  }

  bool loading = true;
  Future<bool> _onBackPressed() async {
    // Your back press code here...
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  isLoggedin: false,
                )));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          child: // WillPopScope(
              // onWillPop: () async => false,
              //child:
              Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height:15, width: 15,),
                  //   dropdownvalue=='Français'?Image.asset('icons/flags/png/fr.png', package: 'country_icons', width: 35, height: 35,):Image.asset('icons/flags/png/gb.png', package: 'country_icons', width: 35, height: 35,),

                  SizedBox(
                    width: 15,
                  ),
                ]),
            backgroundColor:
                Colors.grey[300], //isDarkMode ? Colors.black : Colors.white,
            /*appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
       child: AppBar(
    
          backgroundColor: Colors.white,
         // title: Text("Page de Connexion"),
    
          /*leading: Builder(
      builder: (BuildContext context) {
        return   Row(children: [
          //SizedBox(height:15, width: 15,),
          dropdownvalue=='Français'?Image.asset('icons/flags/png/fr.png', package: 'country_icons', width: 35, height: 35,):Image.asset('icons/flags/png/gb.png', package: 'country_icons', width: 35, height: 35,),
          
             //SizedBox(width: 15,),
          
          Padding(
            padding:EdgeInsets.only(top: 150),
            child: DropdownButton(
                  
                // Initial Value
                value: dropdownvalue,
                  
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down, ),    
                  
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String newValue) { 
                  setState(() {
                    dropdownvalue = newValue;
                  });
                },)
          )
        ]
              );
      },
      ),*/
    
       )
    
        ),
        */
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Center(
                      child: Container(
                          width: 400,
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 50,
                            ),
                            /*Row(
           //crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           
          //SizedBox(height:15, width: 15,),
          dropdownvalue=='Français'?Image.asset('icons/flags/png/fr.png', package: 'country_icons', width: 35, height: 35,):Image.asset('icons/flags/png/gb.png', package: 'country_icons', width: 35, height: 35,),
          
             SizedBox(width: 15,),
          
          DropdownButton(
                  
                // Initial Value
                value: dropdownvalue,
                  
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down, ),    
                  
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String newValue) { 
                  setState(() {
                    dropdownvalue = newValue;
                  });
                },)
        ]
              ),*/

                            Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Center(
                                child: Container(
                                    child: SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Image.asset(
                                          "assets/icons/logo_traite.png",
                                        ))),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  /*IntlPhoneField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(8),
                                    ],
                                    maxLength: 150,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                    //initialCountryCode: 'BFA',
                                    onChanged: (phone) {
                                      print(phone.completeNumber);
                                    },
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 15,
                                        bottom: 0),
                                    child: IntlPhoneField(
                                      initialCountryCode: 'BF',
                                      controller: _nameEditingController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.white // isDarkMode
                                              // ? Colors.white
                                              // : Colors.black,
                                              ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400)),
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        labelText: 'Numéro de téléphone',
                                        //hintText
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        // hintText: 'Numéro'
                                      ),
                                      onChanged: (phone) {
                                        print(phone.completeNumber);
                                        setState(() {
                                          indic = phone.countryCode;
                                          _text = phone.completeNumber;
                                        });
                                      },
                                      onCountryChanged: (country) {
                                        print('Country changed to: ' +
                                            country.name);
                                      },
                                    ),
                                  ),
                                  /* Container(
                                    width: 350,
                                    child: IntlPhoneField(
                                      validator: (value) {
                                        if (value == null ||
                                            value.number == "") {
                                          return "Veuillez entrer le  numéro de telephone";
                                        }
                                        return null;
                                      },
                                      controller: _nameEditingController,
                                      inputFormatters: [
                                        //LengthLimitingTextInputFormatter(8),
                                      ],
                                      //maxLength: 75,
                                      decoration: InputDecoration(
                                          /*icon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),*/
                                          // focusColor: Colors.orange,
                                          enabledBorder: UnderlineInputBorder(
                                            //borderRadius: BorderRadius.circular(5),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'numéro de téléphone',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          hintText: 'numéro de téléphone'),
                                      /*InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),*/
                                      //initialCountryCode: 'BFA',
                                      onChanged: (phone) {
                                        print(phone.completeNumber);

                                        _nameEditingController.text =
                                            phone.completeNumber!;
                                        print('vrai' +
                                            _nameEditingController.text);
                                      },
                                    ),
                                  ),*/
                                  /* Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: TextFormField(
                                      controller: _nameEditingController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp('[ ]')),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          /* icon: Icon(Icons.phone,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black),*/
                                          focusColor: Colors.orange,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color:
                                                    Colors.white // isDarkMode
                                                // ? Colors.white
                                                // : Colors.black,
                                                ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400)),
                                          fillColor: Colors.grey.shade200,
                                          filled: true,
                                          //labelText: 'Numéro de téléphone',
                                          //hintText
                                          labelStyle: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                          hintText: ' Numéro de telephone'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "numéro de téléphone"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 15,
                                        bottom: 0),
                                    //padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: TextFormField(
                                      obscureText: _isObscure,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp('[ ]'))
                                      ],
                                      style: TextStyle(color: Colors.black),
                                      controller: _urlEditingController,
                                      // obscureText: true,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              color: Color(0xff3b22a1),
                                              _isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: _toggleObscure,
                                          ),
                                          // focusColor: Colors.orange,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color:
                                                    Colors.white // isDarkMode
                                                // ? Colors.white
                                                // : Colors.black,
                                                ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400)),
                                          fillColor: Colors.grey.shade200,
                                          filled: true,
                                          labelText: 'Mot de passe',
                                          //hintText
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          hintText: 'Mot de passe'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "password"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: InkWell(
                                        onTap: _text == null || _text == ''
                                            ? null
                                            : () async {
                                                //if (AppResponsive.isMobile(context)){print("mobile");}else print("non mobile");
                                                String username = "54007038";
                                                String password = "2885351";
                                                print("clicked");
                                                String basicAuth = 'Basic ' +
                                                    base64Encode(utf8.encode(
                                                        '$username:$password'));

                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  final response =
                                                      await http.post(
                                                          Uri.parse(
                                                            AppUrl.url +
                                                                'loginUser',
                                                          ),
                                                          headers: <String,
                                                              String>{
                                                            'authorization':
                                                                basicAuth,
                                                            'Content-Type':
                                                                'application/json; charset=UTF-8'
                                                          },
                                                          body: jsonEncode(<
                                                              String, String>{
                                                            "contact": indic! +
                                                                _nameEditingController
                                                                    .text,
                                                            "password":
                                                                _urlEditingController
                                                                    .text,
                                                          }));
                                                  if (response.statusCode ==
                                                      200) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    print(
                                                        ("connexion réussie"));
                                                    print(LoginModel.fromJson(
                                                            jsonDecode(
                                                                response.body))
                                                        .id);
                                                    loginUser(
                                                        LoginModel.fromJson(
                                                                jsonDecode(
                                                                    response
                                                                        .body))
                                                            .id);

                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomePage(
                                                                          isLoggedin:
                                                                              true,
                                                                        )),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  } else if (response
                                                          .statusCode ==
                                                      401) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    //print(ErrorModel.fromJson(jsonDecode(response.body)).title);
                                                    print(response.body +
                                                        "dnndnn");
                                                    print("nonnnnn");
                                                    showDialog(
                                                        // barrierDismissible: false,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text("Alert"),
                                                            content: Text(
                                                                "identifiants invalides"),
                                                            actions: <Widget>[
                                                              MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    /*Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginPage()));*/
                                                                  },
                                                                  child: Text(
                                                                      "ok"))
                                                            ],
                                                          );
                                                        });
                                                  }

                                                  /*else {
                                                print("erreur de connexion");
                                                print("status code = " +
                                                    response.statusCode
                                                        .toString());
                                              }*/
                                                }
                                              },
                                        child: Container(
                                          //color: Colors.red,
                                          height: 50,
                                          width: 250,
                                          decoration: BoxDecoration(
                                              color: _text != null &&
                                                      _text!.isNotEmpty
                                                  ? Color(0xff3b22a1)
                                                  : Colors.grey[
                                                      300], //Color(0xff3b22a1),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text(
                                              "Se connecter",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                      1.7,
                                      InkWell(
                                          onTap: () {
                                            /*   Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));*/
                                          },
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterPage()));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: isDarkMode
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Center(
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegisterPage()));
                                                  },
                                                  child: Text(
                                                    "Créér un compte",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Forgot_Step1Page()));
                                      },
                                      child: Text("Mot de passe oublié?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  loading
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(height: 200),
                                  Text(
                                    "V0.0.1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: //isDarkMode

                                            Colors.black
                                        // : Colors.white,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "contact@relwende.com",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "RelwendeLocations ® 2023",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 130,
                                  ),
                                ],
                              ),
                            )
                          ])))
                ])),
          )),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("INvalids credentials"),
          actions: <Widget>[
            new MaterialButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }
}
