import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/account/account_page.dart';
import 'package:flutter_ecommerce_app/account/login.dart';
import 'package:flutter_ecommerce_app/account/profile_page.dart';
import 'package:flutter_ecommerce_app/data/example_data.dart';
import 'package:flutter_ecommerce_app/pages/cart/shopping_cart.dart';
import 'package:flutter_ecommerce_app/pages/category.dart';
import 'package:flutter_ecommerce_app/pages/home.dart';
import 'package:flutter_ecommerce_app/pages/welcome.dart';
import 'package:flutter_ecommerce_app/widgets/appbar.dart';
import 'package:flutter_ecommerce_app/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecommerce_app/widgets/homePage/category.dart';
import 'package:flutter_ecommerce_app/widgets/homePage/product.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatefulWidget {
  bool? isLoggedin;
  int? id;
  HomePage({this.isLoggedin, this.id});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  int selectedCategory = 0;
  int _selectedIndex = 0;
  late bool? isloggedin;
  @override
  void initState() {
    // TODO: implement initState
    isloggedin = widget.isLoggedin;
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Home(
        isLoggedIn: widget.isLoggedin,
      ),
      CategoryPage(
        isLoggedIn: widget.isLoggedin,
        //counter: widget.counter,
      ),
      CartScreen(
        isLoggedIn: isloggedin,
      ),
      ProfilePage()
    ];
    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode
    Color defaultColor =
        isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black;
    Color secondColor = isDarkMode ? Colors.black : Colors.white;
    return Scaffold(
      //key: _key,
      /*appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.05,
            ),
            child: Icon(
              UniconsLine.search,
              //icon bg color
              color: isDarkMode ? Colors.white : const Color(0xff3b22a1),
              size: size.height * 0.025,
            ),
          ),
        ],
        shadowColor: Colors.transparent,
        backgroundColor: isDarkMode
            ? const Color(0xff06090d)
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
                color: isDarkMode ? Colors.white : const Color(0xff3b22a1),

                size: size.height * 0.025,
              )),
        ),

        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leadingWidth: size.width * 0.15,
        title: Text(
          "LocationTentes",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ) /* Image.asset(
            isDarkMode
                ? 'assets/icons/logo_transparent.png'
                : 'assets/icons/logo_transparent.png', //logo
            height: 150, //size.height * 0.06,
            width: 150 //size.width * 0.95,
            )*/
        ,
        centerTitle: true,
        //title: const Text('TabBar Widget'),
        bottom: TabBar(
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
        ),
      )*/
      /* drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration: BoxDecoration(
                    color: isDarkMode ? Colors.black : Colors.white),
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
                  "assets/icons/SobGOGdark.png",
                  //  height: 500,
                  // width: 500,
                )
                //FlutterLogo(),
                ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text(
                'Nom',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text(
                'Page 2',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),*/
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
      // extendBody: true,
      //extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: size.width * 0.07,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedLabelStyle: const TextStyle(fontSize: 0),
        //currentIndex: currIndex,
        backgroundColor: const Color(0x00ffffff),
        type: BottomNavigationBarType.fixed,
        selectedItemColor:
            isDarkMode ? const Color(0xff3b22a1) : const Color(0xff3b22a1),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
              backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
              //  activeIcon: ,
              icon: Icon(Icons.shopping_cart),
              label: 'Panier',
              backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
        //type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.black,
        // iconSize: 40,
        onTap: _onItemTapped,
        // elevation: 5
      ),

      //buildBottomNavBar(0, size, isDarkMode),
      body: Center(
        child: _widgetOptions.elementAt(
            _selectedIndex), /*Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xff06090d)
                : const Color(0xfff8f8f8), //background color
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Center(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: itemsChairs.length,
                      shrinkWrap: true,
                      primary: false,
                      // physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, i) {
                        return buildProduct(
                          itemsChairs[i]['name'],
                          itemsChairs[i]['room'],
                          itemsChairs[i]['assetURL'],
                          itemsChairs[i]['rating'],
                          itemsChairs[i]['price'],
                          itemsChairs[i]['colors'],
                          defaultColor, //default color
                          secondColor, //second color
                          size, // device size
                        );
                      },
                    ), //Text("It's cloudy here"),
                  ),
                  Center(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: items.length,
                      shrinkWrap: true,
                      primary: false,
                      //physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, i) {
                        print(itemsChairs.length);
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
                    ), //Text("It's cloudy here"),
                  ),
                  Center(
                    child: Text("Tables"),
                  ),
                ],
              ), /*ListView(
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
          ),
        ),*/
      ),
    );
  }
}
