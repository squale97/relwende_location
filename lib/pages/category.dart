import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_ecommerce_app/main.dart';
import 'package:flutter_ecommerce_app/pages/categories_products/product_byCategorie.dart';
import 'package:flutter_ecommerce_app/pages/model/productbyCatModel.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/pages/model/categoryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/example_data.dart';
import 'details_page.dart';

class CategoryPage extends StatefulWidget {
  bool? isLoggedIn;
  //int? counter;
  CategoryPage({
    this.isLoggedIn,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<ProductByCategoryModel?>? _products;
  Future<ProductByCategoryModel?> fetchProducts() async {
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response;
    try {
      response = await http.get(
        AppUrl.url + "produits",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        //body: jsonEncode({"id": "1"}),
      );
    } catch (e) {
      return null;
    }
    //print(response.statusCode);
    if (response.statusCode == 200) {
      //print("ok");
      //  print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(ProductByCategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return ProductByCategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Products');
    }
  }

  Future<CategoryModel?> getCategories() async {
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response;
    try {
      response = await http.get(
        '${AppUrl.url}categories',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
      );
    } catch (e) {
      return null;
    }
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print("ok");
      // print(object)

      /* for (int i = 0;
          i < CategoryModel.fromJson(jsonDecode(response.body)).contenu!.length;
          i++) {
        categories.add(CategoryModel.fromJson(jsonDecode(response.body))
            .contenu![i]
            .libele!);
      }*/
      // print(categories);

      // print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(CategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "category $index"})
          .toList();

  @override
  void initState() {
    // TODO: implement initState
    _products = fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color defaultColor =
        // isDarkMode ? Colors.white.withOpacity(0.8) :
        Colors.black;
    return Scaffold(
        /* bottomSheet: Container(
            //alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
            child: Text("RelwendeLocations ® 2023")),*/
        appBar: AppBar(
          backgroundColor: Color(0xff3b22a1),
          title: Text("Les catégories"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                  height: size.height,
                  width: size.height,
                  decoration: BoxDecoration(
                    color //: isDarkMode
                        // ? const Color(0xff06090d)
                        : const Color(0xfff8f8f8), //background color
                  ),
                  child: SafeArea(
                      child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: ImageSlideshow(
                                    /// Width of the [ImageSlideshow].
                                    width: double.infinity,

                                    /// Height of the [ImageSlideshow].
                                    height: 200,

                                    /// The page to show when first creating the [ImageSlideshow].
                                    initialPage: 0,

                                    /// The color to paint the indicator.
                                    indicatorColor: Colors.blue,

                                    /// The color to paint behind th indicator.
                                    indicatorBackgroundColor: Colors.grey,

                                    /// The widgets to display in the [ImageSlideshow].
                                    /// Add the sample image file into the images folder
                                    children: [
                                      Image.asset(
                                        'assets/icons/slide1.jpeg',
                                        //'https://oui-ceremonie.fr/wp-content/uploads/2019/10/tente-re%CC%81ception-location.png',
                                        fit: BoxFit.cover,
                                      ),
                                      Image.asset(
                                        'assets/icons/slide2.jpeg', //'https://s.alicdn.com/@sc04/kf/H8a0ee69cda114831b0ec4383f23a4639J.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                      Image.asset(
                                        'assets/icons/slide3.jpeg', //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYUfNnBwujGG_UxWGlqyyyD7CBh95O7IAjOw&usqp=CAU',
                                        fit: BoxFit.cover,
                                      ),
                                      Image.asset(
                                        'assets/icons/slide4.jpeg', //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYUfNnBwujGG_UxWGlqyyyD7CBh95O7IAjOw&usqp=CAU',
                                        fit: BoxFit.cover,
                                      ),
                                      Image.asset(
                                        'assets/icons/slide5.jpeg', //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYUfNnBwujGG_UxWGlqyyyD7CBh95O7IAjOw&usqp=CAU',
                                        fit: BoxFit.cover,
                                      ),
                                    ],

                                    /// Called whenever the page in the center of the viewport changes.
                                    onPageChanged: (value) {
                                      print('Page changed: $value');
                                    },

                                    /// Auto scroll interval.
                                    /// Do not auto scroll with null or 0.
                                    autoPlayInterval: 3000,

                                    /// Loops back to first slide.
                                    isLoop: true,
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                  ),
                                ),
                                Expanded(
                                    flex: 6,
                                    // implement GridView.builder
                                    child: SizedBox(
                                        height:
                                            size.height, //size.width * 0.08,
                                        width: size.width * 0.96,
                                        child: FutureBuilder<CategoryModel?>(
                                          future: getCategories(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              200,
                                                          childAspectRatio:
                                                              3 / 2,
                                                          crossAxisSpacing: 20,
                                                          mainAxisSpacing: 20),
                                                  itemCount: snapshot
                                                      .data!.contenu!.length,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    final cat_name = snapshot
                                                        .data!
                                                        .contenu![index]
                                                        .libele;
                                                    final id = snapshot.data!
                                                        .contenu![index].id;
                                                    return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ProductCategoriePage(
                                                                            // counter: widget.counter,
                                                                            isLoggedIn:
                                                                                widget.isLoggedIn,
                                                                            catId:
                                                                                id,
                                                                            catName:
                                                                                cat_name,
                                                                          )));
                                                        },
                                                        child: Card(
                                                          color:
                                                              Colors.grey[300],
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xF0F0F0),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.network(
                                                                      AppUrl.url +
                                                                          'categorieImages/' +
                                                                          id
                                                                              .toString(),
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      // errorBuilder: (),
                                                                      errorBuilder: (context,
                                                                          error,
                                                                          stackTrace) {
                                                                    return Image.asset(
                                                                        "assets/icons/logo_traite.png",
                                                                        height:
                                                                            50, //size.width *
                                                                        //  0.5,
                                                                        width:
                                                                            50, //size.width *
                                                                        // 0.5,
                                                                        fit: BoxFit
                                                                            .contain);
                                                                  }),
                                                                  Text(
                                                                      cat_name!),
                                                                ],
                                                              )),
                                                        ));
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                            }

                                            // By default, show a loading spinner.
                                            return Center(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xff3b22a1)),
                                                ),
                                              ),
                                            );
                                          },
                                        ))),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Text(
                                      "Vous Préfereriez aussi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Card(
                                    color: Colors.grey[300],
                                    child: SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: size.width,
                                          child: FutureBuilder<
                                              ProductByCategoryModel?>(
                                            future: _products,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return GridView.builder(
                                                  //scrollDirection: Axis.horizontal,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 0.65,
                                                  ),
                                                  itemCount: snapshot
                                                      .data!.contenu!.length,
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  //  physics:
                                                  //   const NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final product_name =
                                                        snapshot
                                                            .data!
                                                            .contenu![index]
                                                            .libele;
                                                    final description = snapshot
                                                        .data!
                                                        .contenu![index]
                                                        .description;
                                                    final id = snapshot.data!
                                                        .contenu![index].id
                                                        .toString();
                                                    final id_int = snapshot
                                                        .data!
                                                        .contenu![index]
                                                        .id;
                                                    final cat = snapshot
                                                        .data!
                                                        .contenu![index]
                                                        .libeleCategorie;
                                                    final price = snapshot.data!
                                                        .contenu![index].prix!
                                                        .toDouble();
                                                    final color = snapshot.data!
                                                        .contenu![index].color!;
                                                    print(
                                                        "le id de l'image est :" +
                                                            id!);
                                                    return Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                size.width *
                                                                    0.04,
                                                          ),
                                                          child: InkWell(
                                                            onTap: () => Get.to(
                                                              () => DetailsPage(
                                                                description:
                                                                    description!,
                                                                name:
                                                                    product_name!,
                                                                room: cat!,
                                                                assetURL: AppUrl
                                                                        .url +
                                                                    'produitImages/' +
                                                                    id!,
                                                                rating: 5,
                                                                price: price,
                                                                color: color,
                                                                colors: items[0]
                                                                    ['colors'],
                                                                productId:
                                                                    id_int!,
                                                                isLoggedIn: widget
                                                                    .isLoggedIn!,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Image.network(
                                                                  AppUrl.url +
                                                                      'produitImages/' +
                                                                      id!,
                                                                  height:
                                                                      size.width *
                                                                          0.5,
                                                                  width:
                                                                      size.width *
                                                                          0.5,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  loadingBuilder:
                                                                      (context,
                                                                          child,
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      return child;
                                                                    }
                                                                    return SizedBox(
                                                                      width: size
                                                                              .width *
                                                                          0.5,
                                                                      height:
                                                                          size.width *
                                                                              0.5,
                                                                      child:
                                                                          Align(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  errorBuilder:
                                                                      (context,
                                                                          error,
                                                                          stackTrace) {
                                                                    return Image.asset(
                                                                        "assets/icons/logo_traite.png",
                                                                        height: size.width *
                                                                            0.5,
                                                                        width: size.width *
                                                                            0.5,
                                                                        fit: BoxFit
                                                                            .contain); /*SizedBox(
                                                          width: size.width * 0.5,
                                                          height: size.width * 0.5,
                                                          child: Align(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: defaultColor,
                                                            ),
                                                          ),
                                                        );*/
                                                                  },
                                                                ),
                                                                Text(
                                                                  cat!,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        size.height *
                                                                            0.016,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.5,
                                                                  child: Text(
                                                                    product_name!,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          size.height *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                /* SizedBox(
                                                                  height: size
                                                                          .height *
                                                                      0.0024,
                                                                  width:
                                                                      size.width *
                                                                          0.3,
                                                                  child: ListView
                                                                      .builder(
                                                                    itemCount:
                                                                        5,
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      if (index <
                                                                          5) {
                                                                        return Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              defaultColor,
                                                                          size: size.height *
                                                                              0.025,
                                                                        );
                                                                      } else {
                                                                        return Icon(
                                                                          Icons
                                                                              .star_outline,
                                                                          color:
                                                                              defaultColor,
                                                                          size: size.height *
                                                                              0.025,
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ),*/
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      '$price\ frs',
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color:
                                                                            defaultColor,
                                                                        fontSize:
                                                                            size.height *
                                                                                0.02,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          size.width *
                                                                              0.1,
                                                                      width: size
                                                                              .width *
                                                                          0.1,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              defaultColor,
                                                                          borderRadius:
                                                                              const BorderRadius.all(
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
                                                                              String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
                                                                              if (widget.isLoggedIn!) {
                                                                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                                //Return double
                                                                                int ID = prefs.getInt('ID');

                                                                                final response = await http
                                                                                    .post(
                                                                                        Uri
                                                                                            .parse(
                                                                                          AppUrl.url + 'cart/update',
                                                                                        ),
                                                                                        headers: <String, String>{
                                                                                          'authorization': basicAuth,
                                                                                          'Content-Type': 'application/json; charset=UTF-8'
                                                                                        },
                                                                                        body: jsonEncode({
                                                                                          "user": ID,
                                                                                          "product": id_int,
                                                                                        }));
                                                                                if (response.statusCode == 200) {
                                                                                  setState(() {
                                                                                    // counter = counter + 1;
                                                                                  });

                                                                                  // print("le counter est " +
                                                                                  //counter.toString());
                                                                                  CoolAlert.show(
                                                                                    context: context,
                                                                                    type: CoolAlertType.success,
                                                                                    text: 'Produit ajouté avec succès',
                                                                                    autoCloseDuration: const Duration(seconds: 2),
                                                                                  );

                                                                                  print("ajouté");
                                                                                }
                                                                              } else {
                                                                                CoolAlert.show(
                                                                                  context: context,
                                                                                  type: CoolAlertType.info,
                                                                                  text: 'Vous devez vous connecter pour accéder au panier',
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
                                                    /*buildProduct(
                                          counter,
                                          context,
                                          widget.isLoggedIn!,
                                          id_int!,
                                          product_name!,
                                          description!,
                                          cat!,
                                          AppUrl.url + 'produitImages/' + id!,
                                          5,
                                          price!,
                                          items[index]['colors'],
                                          defaultColor, //default color
                                          secondColor,
                                          color, //second color
                                          size, // device size
                                        );*/
                                                  },
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    "${snapshot.error}");
                                              }

                                              // By default, show a loading spinner.
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xff3b22a1)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]))))),
        ));
  }
}
