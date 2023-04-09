import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/Animation/FadeAnimation.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
        body: Center(
      child: FadeAnimation(
          1.7,
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: () {
                //  Navigator.of(context).push(MaterialPageRoute(
                // builder: (context) => HomePage()));
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: isDarkMode ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    "Ajouter un produit ",
                    style: TextStyle(
                        color: isDarkMode ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )),
    ));
  }
}
