// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_banda_app/ui/screens/food_order_page.dart';
// import 'package:food_banda_app/ui/screens/home_page.dart';
// import 'package:food_banda_app/ui/utils/app_color.dart';
//
// import '../screens/cart_page.dart';
// import '../screens/food_details_page.dart';
//
// class BottomNavBarWidget extends StatefulWidget {
//   @override
//   _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
// }
//
// class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
//   final List<Widget> _screens = [
//     HomePage(),
//     FoodOrderPage(),
//     FoodDetailsPage(),
//     // CartPage(productName:, productPrice:, productImage:, productCartQuantity:,),
//     //  MyAccountPage(),
//   ];
//
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     void _onItemTapped(int index) {
//       setState(() {
//         _selectedIndex = index;
// //        navigateToScreens(index);
//       });
//     }
//
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.fastfood_outlined), label: 'Food Order'),
//           BottomNavigationBarItem(icon: Icon(Icons.food_bank_outlined), label: 'Details page'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.card_giftcard), label: 'Cart'),
//           // BottomNavigationBarItem(
//           //     icon: Icon(Icons.person_outline, size: 28,), label: 'Account'),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: redColor,
//         onTap: (value) {
//           _onItemTapped(value);
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_banda_app/ui/screens/food_order_page.dart';
import 'package:food_banda_app/ui/screens/home_page.dart';
import 'package:food_banda_app/ui/utils/app_color.dart';

import '../screens/cart_page.dart';
import '../screens/food_details_page.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  final List<Widget> _screens = [
    HomePage(),
    FoodOrderPage(),
    FoodDetailsPage(),
    // CartPage(productName:, productPrice:, productImage:, productCartQuantity:,),
    //  MyAccountPage(),
  ];

  late int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
//        navigateToScreens(index);
      });
    }

    return Scaffold(
      body: _screens[_selectedIndex], // Use _selectedIndex to determine the current screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: 'Food Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined), label: 'Details page'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Cart'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.person_outline, size: 28,), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: redColor,
        onTap: (value) {
          _onItemTapped(value); // Call _onItemTapped method instead of assigning the value directly
        },
      ),
    );
  }
}
