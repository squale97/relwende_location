import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "category $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* bottomSheet: Container(
          //alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
          child: Text("RelwendeLocations ® 2023")),*/
      appBar: AppBar(
        backgroundColor: Color(0xff3b22a1),
        title: Text("Les catégories"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                  onTap: () {},
                  child: Card(
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xF0F0F0),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/logo_traite.png",
                              height: 50,
                              width: 50,
                            ),
                            Text(myProducts[index]["name"]),
                          ],
                        )),
                  ));
            }),
      ),
    );
  }
}
