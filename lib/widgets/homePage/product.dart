import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/cart/shopping_cart.dart';
import 'package:flutter_ecommerce_app/pages/details_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

Center buildProduct(
  // String category,
  //int counter,
  BuildContext context,
  bool isLoggedIn,
  // int userId,
  int product,
  String name,
  String description,
  String room,
  String assetURL,
  int rating,
  double price,
  List colors,
  Color defaultColor,
  Color secondColor,
  String color,
  Size size,
) {
  return Center(
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
        ),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsPage(
              description: description,
              name: name,
              room: room,
              assetURL: assetURL,
              rating: rating,
              price: price,
              color: color,
              colors: colors,
              productId: 1,
              isLoggedIn: true,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                assetURL,
                height: size.width * 0.5,
                width: size.width * 0.5,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                    child: Align(
                      child: CircularProgressIndicator(
                        color: defaultColor,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                    child: Align(
                      child: CircularProgressIndicator(
                        color: defaultColor,
                      ),
                    ),
                  );
                },
              ),
              Text(
                room,
                style: GoogleFonts.poppins(
                  color: defaultColor,
                  fontSize: size.height * 0.016,
                ),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    color: defaultColor,
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
                width: size.width * 0.3,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index < rating) {
                      return Icon(
                        Icons.star,
                        color: defaultColor,
                        size: size.height * 0.025,
                      );
                    } else {
                      return Icon(
                        Icons.star_outline,
                        color: defaultColor,
                        size: size.height * 0.025,
                      );
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$price\$',
                    style: GoogleFonts.poppins(
                      color: defaultColor,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: IconButton(
                          onPressed: () async {
                            String username = "54007038";
                            String password = "2885351";
                            print("clicked");
                            String basicAuth = 'Basic ' +
                                base64Encode(
                                    utf8.encode('$username:$password'));
                            if (isLoggedIn) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              //Return double
                              int ID = prefs.getInt('ID');

                              final response = await http.post(
                                  Uri.parse(
                                    AppUrl.url + 'cart/update',
                                  ),
                                  headers: <String, String>{
                                    'authorization': basicAuth,
                                    'Content-Type':
                                        'application/json; charset=UTF-8'
                                  },
                                  body: jsonEncode({
                                    "user": ID,
                                    "product": product,
                                  }));
                              if (response.statusCode == 200) {
                                //counter = counter + 1;
                                // print("le counter est " + counter.toString());
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: 'Produit ajouté avec succès',
                                  autoCloseDuration: const Duration(seconds: 4),
                                );

                                print("ajouté");
                              }
                            } else {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.info,
                                text:
                                    'Vous devez vous connecter pour accéder au panier',
                                autoCloseDuration: const Duration(seconds: 4),
                              );
                              print("se connecter");
                            }
                            //Get.to(CartScreen());
                            //}
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            //UniconsLine.info_circle,
                            color: Colors.white,
                            size: size.width * 0.055,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
