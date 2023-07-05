import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_banda_app/ui/screens/sign_in_page.dart';
import 'package:get/get.dart';

import 'ui/screens/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase from firebase core plugin
  await Firebase.initializeApp();
  runApp(const FoodBandaApp());
}

class FoodBandaApp extends StatelessWidget {
  const FoodBandaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food shop App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // scaffoldBackgroundColor: const Color(0xFFF5F5F3),
        primarySwatch: Colors.blue,
          fontFamily: 'Roboto', hintColor: const Color(0xFFd0cece)
      ),
      home: SignInPage(),
    );
  }
}



