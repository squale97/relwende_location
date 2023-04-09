import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/model/productbyCatModel.dart';
import 'package:http/http.dart' as http;
//TODO: replace example data

Future<ProductByCategoryModel> fetchProductsByCat() async {
  String username = '54007038';
  String password = '2885351';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

  var response = await http.post(
    AppUrl.url,
    headers: <String, String>{'authorization': basicAuth},
    body: {"id": "1"},
  );
  if (response.statusCode == 200) {
    print("ok");
    print(response.body.toString());

    //  setState(() {
    //solde = Solde.fromJson(jsonDecode(response.body)).solde;
    // });
    print(ProductByCategoryModel.fromJson(jsonDecode(response.body)));
    return ProductByCategoryModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Products');
  }
}

/* final response0 = await http.post(Uri.parse(AppUrl.url+'prospecteur/org'),
 
 headers: <String, String>{'Content-Type':'application/json; charset=UTF-8'},
                                body: jsonEncode(<String, String>{
                                  "campagne":campagnesCh![0]
                                 })
 );
 setState(() {
   print('hahhhhh');
   print(widget.orgName);
  // campp = widget.campName!;
    widget.orgName = response0.body;
 print("organisation");
 print(widget.orgName);
 });
 */
// If the server did return a 200 OK response,
// then parse the JSON.

List categories = [
  'Nouveau'
      'Tentes',
  'Chapiteaux',
  'chaises simples',
  'Chaises VIP',
  'Tréteaux',
  'Tables de 10',
  'Tables de 8',
  'Tables carré'
];
List items = [
  {
    'name': 'Chill Seat',
    'room': 'Living Room',
    'assetURL':
        'https://cdn.shopify.com/s/files/1/1461/0984/products/aarnio_originals_ballchair_black_12_1200x.png?v=1619786895',
    'rating': 5,
    'price': 129.99,
    'colors': [Colors.black, Colors.white],
  },
  {
    'name': 'Modern Bed',
    'room': 'Bedroom',
    'assetURL':
        'https://images.ctfassets.net/kthggqw6zjg4/2Qnbxon7HO9IABOklipgkT/3c341ec5c9e1c616a4935d7927aa04fe/Charcoal_1200.png?fit=fill',
    'rating': 5,
    'price': 499.99,
    'colors': [Colors.black, Colors.white],
  },
  {
    'name': 'Family Wardrobe',
    'room': 'Wardrobe',
    'assetURL': 'https://www.elpress.com/hubfs/Garderobe.png',
    'rating': 5,
    'price': 15.99,
    'colors': [Colors.white, Colors.black],
  },
  {
    'name': 'Minimalistic chair',
    'room': 'Living Room',
    'assetURL':
        'https://cdn.pixabay.com/photo/2019/01/29/01/32/chair-3961592__480.png',
    'rating': 2,
    'price': 99.99,
    'colors': [Colors.lime[800], Colors.white, Colors.black],
  },
  {
    'name': 'Portable Chair',
    'room': 'Everywhere',
    'assetURL':
        'https://www.dan-form.com/media/d5iiuemc/arch-chair-pebble-green-boucle-fabric-with-black-metal-legs-100205105-01-main.png?width=1920&mode=crop&heightratio=1',
    'rating': 3,
    'price': 10.99,
    'colors': [Colors.cyan[800], Colors.indigo, Colors.white],
  },
  {
    'name': 'Office Chair',
    'room': 'Office',
    'assetURL':
        'https://cdn.pixabay.com/photo/2019/06/18/06/01/chair-4281511_1280.png',
    'rating': 4,
    'price': 44.99,
    'colors': [Colors.lightBlue, Colors.white, Colors.black],
  },
  {
    'name': 'Office Chair',
    'room': 'Office',
    'assetURL':
        'https://cdn.pixabay.com/photo/2019/06/18/06/01/chair-4281511_1280.png',
    'rating': 4,
    'price': 44.99,
    'colors': [Colors.lightBlue, Colors.white, Colors.black],
  },
  {
    'name': 'Office Chair',
    'room': 'Office',
    'assetURL':
        'https://cdn.pixabay.com/photo/2019/06/18/06/01/chair-4281511_1280.png',
    'rating': 4,
    'price': 44.99,
    'colors': [Colors.lightBlue, Colors.white, Colors.black],
  },
];

List itemsChairs = [
  {
    //'cat': 'Chaises',
    'name': 'Modern Bed',
    'room': 'Bedroom',
    'assetURL':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXbgFX0XLuCF-COqWe2_uJ_NutXGIXiIZb4IyUkuOygA&s',
    'rating': 5,
    'price': 499.99,
    'colors': [Colors.black, Colors.white],
  },
  {
    'name': 'Family Wardrobe',
    'room': 'Wardrobe',
    'assetURL':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdjeAjEmRyI2Lt3v7Xn0xiiltBpBuq1i4Q8Yo5toUwxg&s',
    'rating': 5,
    'price': 15.99,
    'colors': [Colors.white, Colors.black],
  },
  {
    'name': 'Minimalistic chair',
    'room': 'Living Room',
    'assetURL':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEm3QWg9vKFFn5f5cYfn-cn1p-D1lMWAToqNkX9Vd9oA&s',
    'rating': 2,
    'price': 99.99,
    'colors': [Colors.lime[800], Colors.white, Colors.black],
  },
  {
    'name': 'Portable Chair',
    'room': 'Everywhere',
    'assetURL':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhOj4iyVgrnLBydrE8OnTgtrdvhA2qnKaLl_Gb0OEcTQ&s',
    'rating': 3,
    'price': 10.99,
    'colors': [Colors.cyan[800], Colors.indigo, Colors.white],
  },
  {
    'name': 'Office Chair',
    'room': 'Office',
    'assetURL':
        'https://cdn.pixabay.com/photo/2019/06/18/06/01/chair-4281511_1280.png',
    'rating': 4,
    'price': 44.99,
    'colors': [Colors.lightBlue, Colors.white, Colors.black],
  },
];
