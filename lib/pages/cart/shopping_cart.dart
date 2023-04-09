import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/pages/model/cartModel.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff3b22a1),
      title: Column(
        children: [
          Text(
            "Panier",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "${demoCarts.length} items",
            //style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
