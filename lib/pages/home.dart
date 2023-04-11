import 'dart:convert';
import 'package:flutter_ecommerce_app/account/profile_page.dart';
import 'package:flutter_ecommerce_app/account/signup.dart';
import 'package:flutter_ecommerce_app/pages/cart/components/body.dart';
import 'package:flutter_ecommerce_app/pages/cart/shopping_cart.dart';
import 'package:flutter_ecommerce_app/pages/categories_products/product_byCategorie.dart';
import 'package:flutter_ecommerce_app/pages/category.dart';
import 'package:flutter_ecommerce_app/pages/model/categoryModel.dart';
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

//
class Home extends StatefulWidget {
  bool? isLoggedIn;
  Home({this.isLoggedIn});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List categories = [];

  Future<ProductByCategoryModel> fetchProducts() async {
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.get(
      AppUrl.url + "produits",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
      //body: jsonEncode({"id": "1"}),
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

  Future<CategoryModel> getCategories() async {
    String username = '54007038';
    String password = '2885351';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await http.get(
      '${AppUrl.url}categories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCategories();
    //fetchProducts();
    _tabController = TabController(length: 3, vsync: this);
  }

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
    return Scaffold(
      key: _key,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.05,
            ),
            child: IconButton(
              onPressed: () {
                if (widget.isLoggedIn!) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
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
                                          builder: (context) => LoginPage()));
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
          )
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
                Navigator.pop(context);
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
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              title: Text(
                'Commandes',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                  ),
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
                Navigator.pop(context);
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
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('number', null);
                      prefs.setInt('ID', null);
                      setState(() {
                        widget.isLoggedIn = false;
                      });
                      Navigator.pop(context);
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
                            child: FutureBuilder<CategoryModel>(
                                future: getCategories(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.contenu!.length,
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
                                                            catId: int.parse(
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
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }

                                  // By default, show a loading spinner.
                                  return Center(
                                    child: SizedBox(),
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
                    child: FutureBuilder<ProductByCategoryModel>(
                      future: fetchProducts(),
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
                              final id =
                                  snapshot.data!.contenu![index].id.toString();
                              final cat = snapshot
                                  .data!.contenu![index].libeleCategorie;
                              final price = snapshot.data!.contenu![index].prix!
                                  .toDouble();
                              final color =
                                  snapshot.data!.contenu![index].color!;
                              print("le id de l'image est :" + id!);
                              return buildProduct(
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
                              );
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
    );
  }
}
