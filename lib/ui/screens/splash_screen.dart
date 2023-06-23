

import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      //Todo: Add authentication, and take decision based on that. Add isLoggedIn() method in Auth controller
      // bool logInState = await Get.find<AuthController>().isLoggedIn();
      // if (logInState) {
      //   Get.off(() => BottomNavBarScreen());
      // For food app go to Home page
      // } else {
      //   Get.off(() => EmailVerificationScreen());
      // For food app go to SignIn page or Registration page
      // }
      // Navigator.push(context,  MaterialPageRoute(
      //   builder: (context) => HomeScreen(),
      // )),
      // Get.off(() => const BottomNavBarScreen())
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // child: Icon(Icons.shopping_bag_outlined, size: 150),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset('assets/images/logo.png'),
            ),
            Column(
              children: const [
                CircularProgressIndicator(
                  color: primaryColor,
                ),
                // SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    'Version 1.0',
                    style: TextStyle(
                        color: greyColor, fontSize: 17, letterSpacing: 0.5),
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
