import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:flutter_ecommerce_app/pages/welcome.dart';
import 'package:http/http.dart' as http;

import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
//String lang;
  const SplashScreen({Key? key});
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  //String numero = '';
  bool isLoggedin = false;
  int? id;
  @override
  void initState() {
    super.initState();
    showProgress = true;
    loadData();
    // print(widget.lang);
  }

  late bool showProgress;

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    // final response = await http.get(Uri.parse(AppUrl.url + 'status'));

    // print(response.body);
    try {
      // if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String numero = prefs.getString('number');
      int id = prefs.getInt('ID');
      if (numero == null) {
        setState(() {
          isLoggedin = false;
        });
      } else {
        setState(() {
          isLoggedin = true;
          id = prefs.getInt('ID');
        });
      }
      print(numero);
      print(id);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(isLoggedin: isLoggedin, id: id)));

      //LoginPage()));
    } on Exception catch (_) {
      setState(() {
        //showProgress = false;
      });
      print("throwing new error");
      throw Exception("Error on server");
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
/*Locale webLocale = Locale(ui.window.locale.languageCode, '');
              print('system locale is ${webLocale}');
              print(webLocale.toString());
              if (webLocale.toString() =='fr_' )
    {widget.lang = 'Français';}else{widget.lang="English";}

    print(widget.lang);*/
    return Scaffold(
        backgroundColor: Colors.grey[300],
        //isDarkMode ? Colors.black : Colors.white, //AppColor.projPage,
        /*bottomNavigationBar: Container(
       padding: EdgeInsets.only( left: 400),
        child:Text("V1.1", style: TextStyle(color: Colors.orange),),)*/
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
              //  color: AppColor.projPage,
              //image:
              ),
          child: Center(
              child: Column(children: [
            SizedBox(
              height: 200,
            ),
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  isDarkMode
                      ? 'assets/icons/logo_traite.png'
                      : 'assets/icons/logo_traite.png', //logo
                  // height: size.height * 0.06,
                  //width: size.width * 0.35,
                )),
            SizedBox(
              height: 40,
            ),
            showProgress
                ? CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff3b22a1)))
                : TextButton(
                    child: Text("Réessayer"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    }),
            SizedBox(
              height: 200,
            ),
            /*Text(
              "V1.0.1",
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "location.materiel@gmail.com",
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "location ® 2023",
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            )*/
          ])),
        )));
  }
}
