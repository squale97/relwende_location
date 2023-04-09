import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/account/login.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:flutter_ecommerce_app/pages/welcome.dart';
import 'package:flutter_ecommerce_app/widgets/bottom_nav_item.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

Widget buildBottomNavBar(int currIndex, Size size, bool isDarkMode) {
  return BottomNavigationBar(
    iconSize: size.width * 0.07,
    elevation: 0,
    selectedLabelStyle: const TextStyle(fontSize: 0),
    unselectedLabelStyle: const TextStyle(fontSize: 0),
    currentIndex: currIndex,
    backgroundColor: const Color(0x00ffffff),
    type: BottomNavigationBarType.fixed,
    selectedItemColor:
        isDarkMode ? const Color(0xff3b22a1) : const Color(0xff3b22a1),
    unselectedItemColor: Colors.grey,
    onTap: (value) {
      if (value != currIndex) {
        if (value == 0) {
          Get.off(HomePage());
        }
        if (value == 1) {
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          // Get.off(const WelcomePage());
        }
      }
    },
    items: [
      buildBottomNavItem(
        UniconsLine.home,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.heart,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.shopping_cart_alt,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.user,
        isDarkMode,
        size,
      ),
    ],
  );
}
