import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_ecommerce_app/account/profile_page.dart';
import 'package:flutter_ecommerce_app/account/signup.dart';
import 'package:flutter_ecommerce_app/info_user.dart';
import 'package:flutter_ecommerce_app/pages/cart/components/body.dart';
import 'package:flutter_ecommerce_app/pages/cart/shopping_cart.dart';
import 'package:flutter_ecommerce_app/pages/categories_products/product_byCategorie.dart';
import 'package:flutter_ecommerce_app/pages/category.dart';
import 'package:flutter_ecommerce_app/pages/commandes.dart';
import 'package:flutter_ecommerce_app/pages/contact.dart';
import 'package:flutter_ecommerce_app/pages/details_page.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:flutter_ecommerce_app/pages/model/categoryModel.dart';
import 'package:flutter_ecommerce_app/pages/model/panierModel.dart';
import 'package:flutter_ecommerce_app/pages/orders.dart';
import 'package:flutter_ecommerce_app/pages/test_bar.dart';
import 'package:get/get.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/account/login.dart';
import 'package:flutter_ecommerce_app/appUrl.dart';
import 'package:flutter_ecommerce_app/data/example_data.dart';
import 'package:flutter_ecommerce_app/pages/model/productbyCatModel.dart';
import 'package:flutter_ecommerce_app/pages/welcome.dart';
import 'package:flutter_ecommerce_app/widgets/appbar.dart';
import 'package:flutter_ecommerce_app/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecommerce_app/widgets/homePage/category.dart';
import 'package:flutter_ecommerce_app/widgets/homePage/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../connectivity/test_connexion.dart';

//
class Home extends StatefulWidget {
  bool? isLoggedIn;
  Home({this.isLoggedIn});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List categories = [];
  String searchValue = '';

  final List<ContenuS> _prodList = [];
  //late List<ContenuS> _filteredProducts;
  //late List<ContenuS> _searchProducts;
  //late TextEditingController _searchController;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /* void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _searchProducts
          .where((product) =>
              product.libele!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }*/

  Future<PanierModel> fetchPanier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return double
    int ID = prefs.getInt('ID');
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.post(
      AppUrl.url + "panierByUser",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
      body: jsonEncode({"clientId": ID}),
    );
    if (response.statusCode == 200) {
      setState(() {
        counter =
            PanierModel.fromJson(jsonDecode(response.body)).contenu![0].taille!;
        print("taille :" + counter.toString());
      });
      //print("ok");
      //  print(response.body.toString());

      //  setState(() {
      //solde = Solde.fromJson(jsonDecode(response.body)).solde;
      // });
      // print(ProductByCategoryModel.fromJson(jsonDecode(response.body)).contenu);
      return PanierModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Panier');
    }
  }

  Future<void> _pullRefresh() async {
    // if (string != 'Offline') {
    getCategories();
    _products = fetchProducts();
    fetchProducts();
    fetchProductsByCat();

    // List<String> freshNumbers = await NumberGenerator().slowNumbers();

    // }
  }

  late List<ContenuS> _filteredProducts;
  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _prodList
          .where((product) =>
              product.libele!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<ProductByCategoryModel?>? _products;
  Future<CategoryModel?>? _categories;
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
      //print(e);
      return null;
    }

    //print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        for (int i = 0;
            i <
                ProductByCategoryModel.fromJson(jsonDecode(response.body))
                    .contenu!
                    .length;
            i++) {
          _prodList.add(
              ProductByCategoryModel.fromJson(jsonDecode(response.body))
                  .contenu![i]);
          /*_searchProducts.add(
              ProductByCategoryModel.fromJson(jsonDecode(response.body))
                  .contenu![i]);*/
        }
        print(_prodList);
      });

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
      //print(e);
      return null;
    }
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print("ok");
      // print(object)

      for (int i = 0;
          i < CategoryModel.fromJson(jsonDecode(response.body)).contenu!.length;
          i++) {
        categories.add(CategoryModel.fromJson(jsonDecode(response.body))
            .contenu![i]
            .libele!);
      }
      print(categories);

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

  Future<ProductByCategoryModel> fetchProductsByCat() async {
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.post(
      AppUrl.url + "produitByCategorie",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
      body: jsonEncode({"id": "1"}),
    );
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
  /*List<String> items = [
    "Chaises simples",
    "Chaises VIP",
    "Tentes",
    "Chapiteaux",
    "Tables de 8",
    "Tables de 10",
    "Tables carrées",
    "Treteaux",
  ];*/

  /// List of body icon
  List<IconData> icons = [
    Icons.home,
    Icons.explore,
    Icons.search,
    Icons.feed,
    Icons.post_add,
    Icons.local_activity,
    Icons.settings,
    Icons.person
  ];
  int current = 0;
  Icon customIcon = const Icon(
    UniconsLine.search,
    color: Color(0xff3b22a1),
    //icon bg color
    //  color: isDarkMode ? Colors.white : const Color(0xff3b22a1),
    // size: size.height * 0.025,
  );
  Widget customSearchBar = Image.asset(
    "assets/icons/logo_traite.png",
    height: 60,
    width: 60,
    //style: TextStyle(color: Color(0xff3b22a1)),
  );
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  int selectedCategory = 0;
  int _selectedIndex = 0;
  num counter = 0;
  String string = '';
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  @override
  void initState() {
    //fetchProducts();
    _categories = getCategories();
    _products = fetchProducts();
    //fetchProducts();
    if (widget.isLoggedIn!) {
      fetchPanier();
    }
    /* _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      print('source $_source');
      // 1.
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
              _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';

          print(_source.values.toList()[0]);
          if (_source.values.toList()[0] == true) {
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Vérfier votre connexion internet et rafraichir",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            );
          }
          print("mobile nul" + string);
          break;
        case ConnectivityResult.wifi:
          string =
              _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          print("wifi nul" + string);
          break;
        case ConnectivityResult.none:

        default:
          string = 'Offline';
      }
      // 2.
      //  setState(() {});
      // 3.
      print('laconnexion est :' + string);
    });
    if (string != "Offline" || string != "Mobile: Offline") {
    }
    //  _filteredProducts = _searchProducts;
    // _searchController = TextEditingController();

    // TODO: implement initState
    else {}*/
    // fetchPanier();

    // TODO: implement initState
    super.initState();
    // getCategories();
    //fetchProducts();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<String> _filteredData = [];
  final TextEditingController _searchController = TextEditingController();
  /* @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode
    Color defaultColor =
        // isDarkMode ? Colors.white.withOpacity(0.8) :
        Colors.black;
    Color secondColor = /*isDarkMode ?*/ Colors.black /*: Colors.white*/;
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductSearchPage(
                                prods: _prodList,
                                isLoggedIn: widget.isLoggedIn,
                              )));
                },
                icon: Icon(
                  Icons.search,
                  color: Color(0xff3b22a1),
                )),
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.05,
              ),
              child: /*Chip(
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.deepPurple,
        label: Text('BADGE', style: TextStyle(color: Colors.white)),
      ),*/
                  Badge(
                isLabelVisible: true,
                label: widget.isLoggedIn == true
                    ? Text(counter.toString())
                    : Text("0"),
                child: IconButton(
                  onPressed: () {
                    if (widget.isLoggedIn == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen(
                                    isLoggedIn: widget.isLoggedIn,
                                  )));
                    } else {
                      showDialog(
                          // barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Alert"),
                              content: Text(
                                  "Vous devez vous connecter pour accéder au panier"),
                              actions: <Widget>[
                                MaterialButton(
                                    onPressed: () {
                                      //Navigator.of(context).pop();v
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                      /*Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                                  LoginPage()));*/
                                    },
                                    child: Text("ok"))
                              ],
                            );
                          });
                    }
                    /* setState(() {
                        if (customIcon.icon == Icons.search) {
                          customIcon = Icon(
                            Icons.cancel,
                            color: Color(0xff3b22a1),
                          );
                          customSearchBar = ListTile(
                            leading: Icon(
                              Icons.search,
                              color: Color(0xff3b22a1),
                              size: 28,
                            ),
                            title: TextField(
                              decoration: InputDecoration(
                                hintText: "taper le nom d'un produit...",
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          customIcon = const Icon(
                            Icons.search,
                            color: Color(0xff3b22a1),
                          );
                          customSearchBar = Image.asset(
                            'assets/icons/logo_traite.png',
                            height: 60,
                            width: 60,
                            //style: TextStyle(color: Color(0xff3b22a1)),
                          );
                        }
                      })*/
                    ;
                  },
                  icon: Icon(
                    UniconsLine.shopping_cart,
                    color: Color(0xff3b22a1),
                  ),
                ),
              ),
            ),
          ],
          shadowColor: Colors.transparent,
          backgroundColor //: isDarkMode
              //  ? const Color(0xff06090d)
              : const Color(0xfff8f8f8), //appbar bg color
          leading: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
            ),
            child: IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: Icon(
                  UniconsLine.bars,
                  //icon bg color
                  color: Color(0xff3b22a1),

                  size: size.height * 0.025,
                )),
          ),

          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: size.width * 0.15,
          title:
              customSearchBar /* Image.asset(
              isDarkMode
                  ? 'assets/icons/logo_transparent.png'
                  : 'assets/icons/logo_transparent.png', //logo
              height: 150, //size.height * 0.06,
              width: 150 //size.width * 0.95,
              )*/
          ,
          centerTitle: true,
          //title: const Text('TabBar Widget'),
          /*bottom: TabBar(
            indicatorColor: isDarkMode ? Colors.grey : Colors.black,
            labelColor: isDarkMode ? Colors.white : Colors.black,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                text: 'Chaises',
              ),
              Tab(
                text: 'tentes',
                //icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                text: 'tables',
                //icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ),*/
        ),
        drawer: Drawer(
          backgroundColor:
              Color(0xff3b22a1), //isDarkMode ? Colors.black : Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: //isDarkMode ?
                      Colors.white,
                  //:
                  // Colors.black
                ),
                child: Center(
                  child: Image.asset("assets/icons/logo_traite.png"),
                ),
              ),
              /* UserAccountsDrawerHeader(
                  // <-- SEE HERE
                  decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white : Colors.black),
                  accountName: Text(
                    "LocationTentes",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    "locationTentes@gmail.com",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: Image.asset(
                    "assets/icons/logo_traite.png",
                    //  height: 500,
                    // width: 500,
                  )
                  //FlutterLogo(),
                  ),*/
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Accueil',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                isLoggedin: widget.isLoggedIn,
                              )));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                title: Text("Catégories",
                    style: TextStyle(
                        color: Colors
                            .white)) /*DropdownButton(
                  underline: SizedBox(),
                  //value: "Categories",
                  //style: TextStyle(color: Colors.white),
                  items: [
                    //add items in the dropdown
                    DropdownMenuItem(child: Text("New York"), value: "New York"),
    
                    DropdownMenuItem(
                      child: Text("Tokyo"),
                      value: "Tokyo",
                    ),
    
                    DropdownMenuItem(
                      child: Text("Moscow"),
                      value: "Moscow",
                    )
                  ],
                  onChanged: (value) {
                    //get value when changed
                    print("You selected $value");
                  },
                )*/
                ,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CategoryPage()));
                },
              ),
              widget.isLoggedIn == true
                  ? ListTile(
                      leading: Icon(Icons.shopping_cart,
                          color: Colors
                              .white // Color.fromARGB(255, 229, 172, 172),
                          ),
                      title: Text(
                        'Commandes',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        if (widget.isLoggedIn == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderPageD()));
                        } else {
                          showDialog(
                              // barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Alert"),
                                  content: Text("Vous devez vous connecter !"),
                                  actions: <Widget>[
                                    MaterialButton(
                                        onPressed: () {
                                          //Navigator.of(context).pop();v
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                          /*Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                                  LoginPage()));*/
                                        },
                                        child: Text("ok"))
                                  ],
                                );
                              });
                        }
                      },
                    )
                  : SizedBox(),
              widget.isLoggedIn == false
                  ? ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    )
                  : ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Mon Compte',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        if (widget.isLoggedIn!) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoUserPage(
                                        isLoggedIn: widget.isLoggedIn,
                                      )));
                        } else {
                          showDialog(
                              // barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Alert"),
                                  content: Text(
                                      "Vous devez vous connecter pour accéder au panier"),
                                  actions: <Widget>[
                                    MaterialButton(
                                        onPressed: () {
                                          //Navigator.of(context).pop();v
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                          /*Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                                  LoginPage()));*/
                                        },
                                        child: Text("ok"))
                                  ],
                                );
                              });
                        }
                      }),
              widget.isLoggedIn == false
                  ? ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Créér un compte',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                    )
                  : SizedBox(),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                title: Text(
                  'Contact',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactPage()));
                  //Navigator.pop(context);
                },
              ),
              widget.isLoggedIn == false
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Se déconnecter',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () async {
                        showDialog(
                            // barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Alert"),
                                content: Text(
                                    "Etes vous surs de vouloir vous déconnectez?"),
                                actions: <Widget>[
                                  MaterialButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString('number', null);
                                        prefs.setInt('ID', null);
                                        setState(() {
                                          widget.isLoggedIn = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomePage(
                                                      isLoggedin: false,
                                                    )));
                                      },
                                      child: Text("oui")),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Annuler"),
                                  )
                                ],
                              );
                            });

                        /* Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false);*/

                        // Navigator.pushAndRemoveUntil(context, newRoute, () => false)
                        /*CoolAlert.show(
                          context: context,
                          type: CoolAlertType.info,
                          text: 'Vous etes déconnecté',
                          autoCloseDuration: const Duration(seconds: 2),
                        );*/
                        //Return String
                      },
                    )
            ],
          ),
        ),
        /*buildAppBar(
          Icon(
            UniconsLine.bars,
            //icon bg color
            color: isDarkMode ? Colors.white : const Color(0xff3b22a1),
    
            size: size.height * 0.025,
          ),
          Icon(
            UniconsLine.search,
            //icon bg color
            color: isDarkMode ? Colors.white : const Color(0xff3b22a1),
            size: size.height * 0.025,
          ),
          isDarkSearMode,
          size,
        )*/
        extendBody: true,
        extendBodyBehindAppBar: true,

        //buildBottomNavBar(0, size, isDarkMode),
        body: Center(
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
                child: ListView(
                  children: [
                    /* Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        //controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                        ),
                        // onChanged: _filterProducts,
                      ),
                    ),*/
                    ImageSlideshow(
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
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/icons/slide2.jpeg',
                          //'https://s.alicdn.com/@sc04/kf/H8a0ee69cda114831b0ec4383f23a4639J.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/icons/slide3.jpeg',
                          //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYUfNnBwujGG_UxWGlqyyyD7CBh95O7IAjOw&usqp=CAU',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/icons/slide4.jpeg',
                          //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYUfNnBwujGG_UxWGlqyyyD7CBh95O7IAjOw&usqp=CAU',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/icons/slide5.jpeg',
                          //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYUfNnBwujGG_UxWGlqyyyD7CBh95O7IAjOw&usqp=CAU',
                          fit: BoxFit.cover,
                        ),
                      ],

                      /// Called whenever the page in the center of the viewport changes.
                      onPageChanged: (value) {
                        //print('Page changed: $value');
                      },

                      /// Auto scroll interval.
                      /// Do not auto scroll with null or 0.
                      autoPlayInterval: 3000,

                      /// Loops back to first slide.
                      isLoop: true,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.01,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              height: 100, //size.width * 0.08,
                              width: size.width * 0.96,
                              child: FutureBuilder<CategoryModel?>(
                                  future: _categories, //getCategories(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return RefreshIndicator(
                                        onRefresh: _pullRefresh,
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data!.contenu!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final cat_id = snapshot
                                                .data!.contenu![index].id
                                                .toString();
                                            final name = snapshot
                                                .data!.contenu![index].libele;
                                            /*if (index == selectedCategory) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 0.02,
                                                ),
                                                child: buildCategory(
                                                  AppUrl.url +
                                                      'categorieImages/' +
                                                      cat_id,
                                                  name!,
                                                  secondColor,
                                                  defaultColor,
                                                  size,
                                                ),
                                              );
                                            } else {*/
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.02,
                                              ),
                                              child: InkWell(
                                                onTap: () => setState(() {
                                                  selectedCategory = index;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductCategoriePage(
                                                                // counter: counter,
                                                                isLoggedIn: widget
                                                                    .isLoggedIn,
                                                                catId:
                                                                    int.parse(
                                                                        cat_id),
                                                                catName: name,
                                                              )));
                                                }),
                                                child: buildCategory(
                                                  AppUrl.url +
                                                      'categorieImages/' +
                                                      cat_id,
                                                  name!,
                                                  defaultColor,
                                                  Colors.black,
                                                  size,
                                                ),
                                              ),
                                            );
                                            // }
                                          },
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    // By default, show a loading spinner.
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xff3b22a1)),
                                      ),
                                    );
                                  })),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "   Nos Produits",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: size.width,
                      child: FutureBuilder<ProductByCategoryModel?>(
                        future: _products!,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                              ),
                              itemCount: snapshot.data!.contenu!.length,
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final product_name =
                                    snapshot.data!.contenu![index].libele;
                                final description =
                                    snapshot.data!.contenu![index].description;
                                final id = snapshot.data!.contenu![index].id
                                    .toString();
                                final id_int =
                                    snapshot.data!.contenu![index].id;
                                final cat = snapshot
                                    .data!.contenu![index].libeleCategorie;
                                final price = snapshot
                                    .data!.contenu![index].prix!
                                    .toDouble();
                                final color =
                                    snapshot.data!.contenu![index].color!;
                                print("le id de l'image est :" + id!);
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
                                            description: description!,
                                            name: product_name!,
                                            room: cat!,
                                            assetURL: AppUrl.url +
                                                'produitImages/' +
                                                id!,
                                            rating: 5,
                                            price: price,
                                            color: color,
                                            colors: items[0]['colors'],
                                            productId: id_int!,
                                            isLoggedIn: widget.isLoggedIn!,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image.network(
                                              AppUrl.url +
                                                  'produitImages/' +
                                                  id!,
                                              height: size.width * 0.5,
                                              width: size.width * 0.5,
                                              fit: BoxFit.contain,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return SizedBox(
                                                  width: size.width * 0.5,
                                                  height: size.width * 0.5,
                                                  child: Align(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: defaultColor,
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    "assets/icons/logo_traite.png",
                                                    height: size.width * 0.5,
                                                    width: size.width * 0.5,
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
                                              style: GoogleFonts.poppins(
                                                color: defaultColor,
                                                fontSize: size.height * 0.016,
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.5,
                                              child: Text(
                                                product_name!,
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  if (index < 5) {
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '$price\ frs',
                                                  style: GoogleFonts.poppins(
                                                    color: defaultColor,
                                                    fontSize:
                                                        size.height * 0.02,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.width * 0.1,
                                                  width: size.width * 0.1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: defaultColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                          10,
                                                        ),
                                                      ),
                                                    ),
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          String username =
                                                              "54007038";
                                                          String password =
                                                              "2885351";
                                                          print("clicked");
                                                          String basicAuth =
                                                              'Basic ' +
                                                                  base64Encode(
                                                                      utf8.encode(
                                                                          '$username:$password'));
                                                          if (widget
                                                              .isLoggedIn!) {
                                                            SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            //Return double
                                                            int ID = prefs
                                                                .getInt('ID');

                                                            final response =
                                                                await http.post(
                                                                    Uri.parse(
                                                                      AppUrl.url +
                                                                          'cart/update',
                                                                    ),
                                                                    headers: <
                                                                        String,
                                                                        String>{
                                                                      'authorization':
                                                                          basicAuth,
                                                                      'Content-Type':
                                                                          'application/json; charset=UTF-8'
                                                                    },
                                                                    body:
                                                                        jsonEncode({
                                                                      "user":
                                                                          ID,
                                                                      "product":
                                                                          id_int,
                                                                    }));
                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              setState(() {
                                                                counter =
                                                                    counter + 1;
                                                              });

                                                              print("le counter est " +
                                                                  counter
                                                                      .toString());
                                                              CoolAlert.show(
                                                                context:
                                                                    context,
                                                                type:
                                                                    CoolAlertType
                                                                        .success,
                                                                text:
                                                                    'Produit ajouté avec succès',
                                                                autoCloseDuration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2),
                                                              );

                                                              print("ajouté");
                                                            }
                                                          } else {
                                                            CoolAlert.show(
                                                              context: context,
                                                              type:
                                                                  CoolAlertType
                                                                      .info,
                                                              text:
                                                                  'Vous devez vous connecter pour accéder au panier',
                                                              autoCloseDuration:
                                                                  const Duration(
                                                                      seconds:
                                                                          4),
                                                            );
                                                            print(
                                                                "se connecter");
                                                          }
                                                          //Get.to(CartScreen());
                                                          //}
                                                        },
                                                        icon: Icon(
                                                          Icons.shopping_cart,
                                                          //UniconsLine.info_circle,
                                                          color: Colors.white,
                                                          size: size.width *
                                                              0.055,
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
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff3b22a1)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /*ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.01,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: size.width * 0.08,
                            width: size.width * 0.96,
                            child: ListView.builder(
                              itemCount: categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index == selectedCategory) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02,
                                    ),
                                    child: buildCategory(
                                      categories[index],
                                      secondColor,
                                      defaultColor,
                                      size,
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02,
                                    ),
                                    child: InkWell(
                                      onTap: () => setState(() {
                                        selectedCategory = index;
                                        print('tapé');
                                      }),
                                      child: buildCategory(
                                        categories[index],
                                        defaultColor,
                                        secondColor,
                                        size,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: items.length,
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          return buildProduct(
                            items[i]['name'],
                            items[i]['room'],
                            items[i]['assetURL'],
                            items[i]['rating'],
                            items[i]['price'],
                            items[i]['colors'],
                            defaultColor, //default color
                            secondColor, //second color
                            size, // device size
                          );
                        },
                      ),
                    ),
                  ],
                )*/
      ),
    );
  }
}

class ProductS {
  String? couleur;
  String? description;
  int? id;
  int? idCategorie;
  String? image;
  Null? index;
  String? libele;
  String? libeleCategorie;
  int? prix;
  String? reference;
  int? stock;

  ProductS(
      {this.couleur,
      this.description,
      this.id,
      this.idCategorie,
      this.image,
      this.index,
      this.libele,
      this.libeleCategorie,
      this.prix,
      this.reference,
      this.stock});

  ProductS.fromJson(Map<String, dynamic> json) {
    couleur = json['couleur'];
    description = json['description'];
    id = json['id'];
    idCategorie = json['idCategorie'];
    image = json['image'];
    index = json['index'];
    libele = json['libele'];
    libeleCategorie = json['libeleCategorie'];
    prix = json['prix'];
    reference = json['reference'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couleur'] = this.couleur;
    data['description'] = this.description;
    data['id'] = this.id;
    data['idCategorie'] = this.idCategorie;
    data['image'] = this.image;
    data['index'] = this.index;
    data['libele'] = this.libele;
    data['libeleCategorie'] = this.libeleCategorie;
    data['prix'] = this.prix;
    data['reference'] = this.reference;
    data['stock'] = this.stock;
    return data;
  }
}
