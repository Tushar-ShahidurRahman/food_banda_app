import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// import 'package:flutter_app/animation/ScaleRoute.dart';
// import 'package:flutter_app/pages/FoodDetailsPage.dart';
// import 'package:flutter_app/pages/SignUpPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_banda_app/ui/screens/home_page.dart';

// import 'package:food_banda_app/data/service/auth_service.dart';
import 'package:get/get.dart';

import '../../data/service/auth_service.dart';
import '../animation/scale_route.dart';
import 'sign_up_page.dart';
import 'menu_page.dart';

class SignInPage extends StatelessWidget {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    UserCredential? result =
        await _authService.logInWithEmailAndPassword(email, password);

    if (result != null) {
      User user = result.user!;
      String? role = await _authService.getUserRoleFromDatabase(user.uid);

      if (role == 'Seller') {
        Get.offAll(() => MenuPage(role: 'Seller'));
      } else if (role == 'Buyer') {
        Get.offAll(() => HomePage());
      } else {
        showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: Text('Login Error'),
            content: Text('Invalid role.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: Text('Login Error'),
          content: Text('Invalid email or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: InkWell(
                child: Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.close),
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ),
            Flexible(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   width: 230,
                  //   height: 100,
                  //   alignment: Alignment.center,
                  //   child:
                  //       Image.asset("assets/images/menus/ic_food_express.png"),
                  // ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize),
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF666666),
                        size: defaultIconSize,

                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize),
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 15),
                  SignInButtonWidget(onPressed: _login),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignUpPage());
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                          ),
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInButtonWidget extends StatelessWidget {
  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 14;
  double defaultIconSize = 17;
  final VoidCallback onPressed;

   SignInButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF17ead9),
            Color(0xFF6078ea),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 16),
        onPressed: onPressed,
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontFamily: defaultFontFamily,
            fontSize: defaultFontSize,
          ),
        ),
      ),
    );
  }
}



// Other try

// class SignInPage extends StatefulWidget {
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//   final AuthService _authService = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   Future<void> _login() async {
//     String email = _emailController.text;
//     String password = _passwordController.text;
//
//     UserCredential? result =
//     await _authService.logInWithEmailAndPassword(email, password);
//
//     if (result != null) {
//       // Get the user object from the result
//       User user = result.user!;
//
//       // Check the user's role and navigate accordingly
//       // if (user) {
//       // Get the user's role from the user document in the database
//       String? role = await _authService.getUserRoleFromDatabase(user.uid);
//       // String role = widget.role!;
//
//       if (role == 'teacher') {
//         // Navigate to the teacher module
//       //   Get.offAll(() => DashboardScreen(userRole: 'teacher'));
//       // } else if (role == 'student') {
//       //   Get.offAll(() => DashboardScreen(userRole: 'student'));
//       } else {
//         // Invalid role, show an error message
//         if (mounted) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Login Error'),
//               content: Text('Invalid role.'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       }
//       // }
//     } else {
//       // Show error message to the user
//       if (mounted) {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Login Error'),
//             content: Text('Invalid email or password.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String defaultFontFamily = 'Roboto-Light.ttf';
//     double defaultFontSize = 14;
//     double defaultIconSize = 17;
//
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.white70,
//         child: Column(
//           children: <Widget>[
//             Flexible(
//               flex: 1,
//               child: InkWell(
//                 child: Container(
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Icon(Icons.close),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             Flexible(
//               flex: 8,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     width: 230,
//                     height: 100,
//                     alignment: Alignment.center,
//                     child: Image.asset(
//                       "assets/images/menus/ic_food_express.png",
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     showCursor: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           width: 0,
//                           style: BorderStyle.none,
//                         ),
//                       ),
//                       filled: true,
//                       prefixIcon: Icon(
//                         Icons.phone,
//                         color: Color(0xFF666666),
//                         size: defaultIconSize,
//                       ),
//                       fillColor: Color(0xFFF2F3F5),
//                       hintStyle: TextStyle(
//                           color: Color(0xFF666666),
//                           fontFamily: defaultFontFamily,
//                           fontSize: defaultFontSize),
//                       hintText: "Phone Number",
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     showCursor: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           width: 0,
//                           style: BorderStyle.none,
//                         ),
//                       ),
//                       filled: true,
//                       prefixIcon: Icon(
//                         Icons.lock_outline,
//                         color: Color(0xFF666666),
//                         size: defaultIconSize,
//                       ),
//                       suffixIcon: Icon(
//                         Icons.remove_red_eye,
//                         color: Color(0xFF666666),
//                         size: defaultIconSize,
//                       ),
//                       fillColor: Color(0xFFF2F3F5),
//                       hintStyle: TextStyle(
//                         color: Color(0xFF666666),
//                         fontFamily: defaultFontFamily,
//                         fontSize: defaultFontSize,
//                       ),
//                       hintText: "Password",
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     child: Text(
//                       "Forgot your password?",
//                       style: TextStyle(
//                         color: Color(0xFF666666),
//                         fontFamily: defaultFontFamily,
//                         fontSize: defaultFontSize,
//                         fontStyle: FontStyle.normal,
//                       ),
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   SignInButtonWidget(),
//                   SizedBox(
//                     height: 2,
//                   ),
//                   FacebookGoogleLogin()
//                 ],
//               ),
//             ),
//             Flexible(
//               flex: 1,
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       child: Text(
//                         "Don't have an account? ",
//                         style: TextStyle(
//                           color: Color(0xFF666666),
//                           fontFamily: defaultFontFamily,
//                           fontSize: defaultFontSize,
//                           fontStyle: FontStyle.normal,
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => {
//                         Navigator.push(context, ScaleRoute(page: SignUpPage()))
//                       },
//                       child: Container(
//                         child: Text(
//                           "Sign Up",
//                           style: TextStyle(
//                             color: Color(0xFFf7418c),
//                             fontFamily: defaultFontFamily,
//                             fontSize: defaultFontSize,
//                             fontStyle: FontStyle.normal,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SignInButtonWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: new BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: Color(0xFFfbab66),
//           ),
//           BoxShadow(
//             color: Color(0xFFf7418c),
//           ),
//         ],
//         gradient: new LinearGradient(
//             colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
//             begin: const FractionalOffset(0.2, 0.2),
//             end: const FractionalOffset(1.0, 1.0),
//             stops: [0.0, 1.0],
//             tileMode: TileMode.clamp),
//       ),
//       child: MaterialButton(
//           highlightColor: Colors.transparent,
//           splashColor: Color(0xFFf7418c),
//           //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//           child: Padding(
//             padding:
//             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
//             child: Text(
//               "SIGN IN",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 25.0,
//                   fontFamily: "WorkSansBold"),
//             ),
//           ),
//           onPressed:
// _login,
//           ),
//     );
//   }
// }
//
// class FacebookGoogleLogin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(top: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: new LinearGradient(
//                           colors: [
//                             Colors.black12,
//                             Colors.black54,
//                           ],
//                           begin: const FractionalOffset(0.0, 0.0),
//                           end: const FractionalOffset(1.0, 1.0),
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.clamp),
//                     ),
//                     width: 100.0,
//                     height: 1.0,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                     child: Text(
//                       "Or",
//                       style: TextStyle(
//                           color: Color(0xFF2c2b2b),
//                           fontSize: 16.0,
//                           fontFamily: "WorkSansMedium"),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: new LinearGradient(
//                           colors: [
//                             Colors.black54,
//                             Colors.black12,
//                           ],
//                           begin: const FractionalOffset(0.0, 0.0),
//                           end: const FractionalOffset(1.0, 1.0),
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.clamp),
//                     ),
//                     width: 100.0,
//                     height: 1.0,
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 10.0, right: 40.0),
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       padding: const EdgeInsets.all(15.0),
//                       decoration: new BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFFf7418c),
//                       ),
//                       child: Icon(
//                         FontAwesomeIcons.facebookF,
//                         color: Color(0xFFFFFFFF),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: GestureDetector(
//                     onTap: () => {},
//                     child: Container(
//                       padding: const EdgeInsets.all(15.0),
//                       decoration: new BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFFf7418c),
//                       ),
//                       child: new Icon(
//                         FontAwesomeIcons.google,
//                         color: Color(0xFFFFFFFF),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }