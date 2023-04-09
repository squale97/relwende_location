import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/size_config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
            //alignment: Alignment.bottomCenter,
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
            child: Text("RelwendeLocations ® 2023")),
        appBar: AppBar(
          backgroundColor: Color(0xff3b22a1),
          title: Text("Mon Profile"),
        ),
        body: Center(
          child: Center(
              child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {},
                  child: Card(
                      child: ListTile(
                          trailing: Icon(Icons.arrow_circle_right),
                          leading: Icon(Icons.info),
                          title: Text(
                            "Mes Informations",
                          )))),
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {},
                  child: Card(
                      child: ListTile(
                          trailing: Icon(Icons.arrow_circle_right),
                          leading: Icon(Icons.edit),
                          title: Text(
                            "Modifier mes Informations",
                          )))),
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {},
                  child: Card(
                      child: ListTile(
                          trailing: Icon(Icons.arrow_circle_right),
                          leading: Icon(Icons.lock),
                          title: Text(
                            "Réinitialiser mon mon de passe",
                          )))),
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {},
                  child: Card(
                      child: ListTile(
                          trailing: Icon(Icons.arrow_circle_right),
                          leading: Icon(Icons.shopping_cart),
                          title: Text(
                            "Mes commandes",
                          )))),
              SizedBox(
                height: 15,
              )
            ],
          )),
        ));
  }
}
