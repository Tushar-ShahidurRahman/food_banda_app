import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_banda_app/data/service/auth_service.dart';
import 'package:food_banda_app/ui/screens/food_order_page.dart';
import 'package:food_banda_app/ui/screens/home_page.dart';
import 'package:get/get.dart';

import '../animation/scale_route.dart';
import 'menu_page.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _invitationCodeController = TextEditingController();

  String selectedRole = '';

  Future<void> _registerUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;


    UserCredential? result =
    await _authService.registerWithEmailAndPassword(email, password);

    if (result != null) {
      // Registration successful, add role to user document
      User user = result.user!;
      _authService.addUserToFirestore(selectedRole, user, email, password, firstName, lastName);

      // Navigate to appropriate module based on role
      if (selectedRole == 'Buyer') {
        // Get.offAll(() => MenuPage(role: 'Buyer'));
        Get.offAll(() => HomePage());
      } else if (selectedRole == 'Seller') {
        Get.offAll(() => MenuPage(role: 'Seller'));
        // There is actually no chance for user to enter any role other than these two.
      } else {
        // Invalid role, show an error message
        Get.defaultDialog(
          title: 'Registration Error',
          content: const Text('Invalid role.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      }
    } else {
      // Show error message to the user
      Get.defaultDialog(
        title: 'Registration Error',
        content: const Text('Invalid email or password.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: InkWell(
                child: Container(
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.close),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Flexible(
              flex: 15,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _firstNameController,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: const Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: "First Name",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _lastNameController,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: const Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: "Last Name",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _emailController,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: const Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: const Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: const Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _passwordController,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: const Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: const Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                          color: const Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                        ),
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _invitationCodeController,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.code,
                          color: const Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: const Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                          color: const Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                        ),
                        hintText: "Invitation Code",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.info_outline,
                            color: const Color(0xFF666666),
                            size: defaultIconSize,
                          ),
                          Text(
                            " Leave empty if you don't have Invitation Code",
                            style: TextStyle(
                              color: const Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedRole.isEmpty ? null : selectedRole,
                      hint: const Text('Select Role'),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                      items: ['Buyer', 'Seller'].map((role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInButtonWidget(onPressed: _registerUser),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          ScaleRoute(page: SignInPage()),
                        );
                      },
                      child: Container(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: const Color(0xFFf7418c),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignInButtonWidget extends StatelessWidget {

  final VoidCallback onPressed;

  const SignInButtonWidget({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFFfbab66),
          ),
          BoxShadow(
            color: Color(0xFFf7418c),
          ),
        ],
        gradient: LinearGradient(
          colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
          begin: FractionalOffset(0.2, 0.2),
          end: FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: const Color(0xFFf7418c),
        onPressed: onPressed,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
          child: Text(
            "SIGN UP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: "WorkSansBold",
            ),
          ),
        ),
      ),
    );
  }


}
















// import 'package:flutter/material.dart';
//
// // import 'package:flutter_app/animation/ScaleRoute.dart';
// // import 'package:flutter_app/pages/SignInPage.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
//
// import '../animation/scale_route.dart';
// import 'sign_in_page.dart';
//
// class SignUpPage extends StatelessWidget {
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
//               flex: 15,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   // Container(
//                   //   width: 230,
//                   //   height: 100,
//                   //   alignment: Alignment.center,
//                   //   child: Image.asset(
//                   //     "assets/images/menus/ic_food_express.png",
//                   //   ),
//                   // ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Flexible(
//                         flex: 1,
//                         child: TextField(
//                           // controller: ,
//                           showCursor: true,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               borderSide: BorderSide(
//                                 width: 0,
//                                 style: BorderStyle.none,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor: Color(0xFFF2F3F5),
//                             hintStyle: TextStyle(
//                               color: Color(0xFF666666),
//                               fontFamily: defaultFontFamily,
//                               fontSize: defaultFontSize,
//                             ),
//                             hintText: "First Name",
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Flexible(
//                         flex: 1,
//                         child: TextField(
//                           // controller: ,
//                           showCursor: true,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               borderSide: BorderSide(
//                                 width: 0,
//                                 style: BorderStyle.none,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor: Color(0xFFF2F3F5),
//                             hintStyle: TextStyle(
//                               color: Color(0xFF666666),
//                               fontFamily: defaultFontFamily,
//                               fontSize: defaultFontSize,
//                             ),
//                             hintText: "Last Name",
//                           ),
//                         ),
//                       ),
//                     ],
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
//                         Icons.email_outlined,
//                         color: Color(0xFF666666),
//                         size: defaultIconSize,
//                       ),
//                       fillColor: Color(0xFFF2F3F5),
//                       hintStyle: TextStyle(
//                           color: Color(0xFF666666),
//                           fontFamily: defaultFontFamily,
//                           fontSize: defaultFontSize),
//                       hintText: "Email",
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
//                       fillColor: Color(0xFFF2F3F5),
//                       hintStyle: TextStyle(
//                         color: Color(0xFF666666),
//                         fontFamily: defaultFontFamily,
//                         fontSize: defaultFontSize,
//                       ),
//                       hintText: "Password",
//                     ),
//                   ),
//                   SizedBox(height: 10),
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
//                         Icons.code,
//                         color: Color(0xFF666666),
//                         size: defaultIconSize,
//                       ),
//                       fillColor: Color(0xFFF2F3F5),
//                       hintStyle: TextStyle(
//                         color: Color(0xFF666666),
//                         fontFamily: defaultFontFamily,
//                         fontSize: defaultFontSize,
//                       ),
//                       hintText: "Invitation Code",
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: <Widget>[
//                           Icon(
//                             Icons.info_outline,
//                             color: Color(0xFF666666),
//                             size: defaultIconSize,
//                           ),
//                           Text(
//                             " Leave empty if you don't have Invitation Code",
//                             style: TextStyle(
//                               color: Color(0xFF666666),
//                               fontFamily: defaultFontFamily,
//                               fontSize: defaultFontSize,
//                               fontStyle: FontStyle.normal,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   SignInButtonWidget(),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   // FacebookGoogleLogin()
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
//                         "Already have an account? ",
//                         style: TextStyle(
//                           color: Color(0xFF666666),
//                           fontFamily: defaultFontFamily,
//                           fontSize: defaultFontSize,
//                           fontStyle: FontStyle.normal,
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(context, ScaleRoute(page: SignInPage()));
//                       },
//                       child: Container(
//                         child: Text(
//                           "Sign In",
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
//
//
//
//
//   Future<void> _registerUser() async {
//     final email = _emailController.text;
//     final password = _passwordController.text;
//
//     UserCredential? result =
//     await _authService.registerWithEmailAndPassword(email, password);
//
//     if (result != null) {
//       // Registration successful, add role to user document
//       User user = result.user!;
//       _authService.addUserToFirestore(selectedRole!, user, email, password);
//
//       // Navigate to appropriate module based on role
//       if (selectedRole == 'teacher') {
//         Get.offAll(() => DashboardScreen(userRole: 'teacher'));
//       } else if (selectedRole == 'student') {
//         Get.offAll(() => DashboardScreen(userRole: 'student'));
//         // There is actually no chance for user to enter any role other than these two.
//       } else {
//         // Invalid role, show an error message
//         Get.defaultDialog(
//           title: 'Registration Error',
//           content: const Text('Invalid role.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       }
//     } else {
//       // Show error message to the user
//       Get.defaultDialog(
//         title: 'Registration Error',
//         content: const Text('Invalid email or password.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       );
//     }
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
//                 const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
//             child: Text(
//               "SIGN UP",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 25.0,
//                   fontFamily: "WorkSansBold"),
//             ),
//           ),
//           onPressed:
//               // () => {
//           //   register with email and password. plus
//           //  write the user in firestore.
//             _registerUser,
//           // }
//           ),
//     );
//   }
//
//
// }












// Facebook and google login
// class FacebookGoogleLogin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: new LinearGradient(
//                       colors: [
//                         Colors.black12,
//                         Colors.black54,
//                       ],
//                       begin: const FractionalOffset(0.0, 0.0),
//                       end: const FractionalOffset(1.0, 1.0),
//                       stops: [0.0, 1.0],
//                       tileMode: TileMode.clamp),
//                 ),
//                 width: 100.0,
//                 height: 1.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                 child: Text(
//                   "Or",
//                   style: TextStyle(
//                       color: Color(0xFF2c2b2b),
//                       fontSize: 16.0,
//                       fontFamily: "WorkSansMedium"),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: new LinearGradient(
//                       colors: [
//                         Colors.black54,
//                         Colors.black12,
//                       ],
//                       begin: const FractionalOffset(0.0, 0.0),
//                       end: const FractionalOffset(1.0, 1.0),
//                       stops: [0.0, 1.0],
//                       tileMode: TileMode.clamp),
//                 ),
//                 width: 100.0,
//                 height: 1.0,
//               ),
//             ],
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(top: 10.0, right: 40.0),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   padding: const EdgeInsets.all(15.0),
//                   decoration: new BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFFf7418c),
//                   ),
//                   child: new Icon(
//                     FontAwesomeIcons.facebookF,
//                     color: Color(0xFFFFFFFF),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 10.0),
//               child: GestureDetector(
//                 onTap: () => {},
//                 child: Container(
//                   padding: const EdgeInsets.all(15.0),
//                   decoration: new BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFFf7418c),
//                   ),
//                   child: new Icon(
//                     FontAwesomeIcons.google,
//                     color: Color(0xFFFFFFFF),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ));
//   }
// }
