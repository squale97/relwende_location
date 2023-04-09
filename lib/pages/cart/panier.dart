import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({super.key});

  @override
  State<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Panier"),
        ),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text("un polytank"),
              ),
            ),
            Card(
              color: Colors.grey,
              child: ListTile(
                title: Text("noir"),
                trailing: Wrap(
                  spacing: 3, // space between two icons
                  children: <Widget>[
                    TextButton(onPressed: () {}, child: Text('-')), // icon-1
                    TextButton(
                      onPressed: () {},
                      child: Text('1'),
                    ),
                    TextButton(onPressed: () {}, child: Text('+')) // icon-2
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Polytank blanc'),
            )
          ],
        ));
  }
}
