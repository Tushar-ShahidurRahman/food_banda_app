import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../animation/scale_route.dart';
import '../custom_widgets/best_food_widget.dart';
import '../custom_widgets/bottom_nav_bar_widget.dart';
import '../custom_widgets/popular_foods_widget.dart';
import '../custom_widgets/search_widget.dart';
import '../custom_widgets/top_menus.dart';
import 'sign_in_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print('######## PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ##########');
    print(deviceToken);
    print('##############################################');

  //  Listen for user to click on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;

    //  An alert dialogue
      Get.defaultDialog(title: title!, content: Text(description!), actions: [TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Close'),
      ),] );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        title: const Text(
          "What would you like to eat?",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        // brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {Navigator.push(context, ScaleRoute(page: SignInPage()));})
        ],
      ),

      // Removed Singlechile scroll view, I dont think this is a good idea.
      // Will add it later.
      body: Column(
        children: <Widget>[
          SearchWidget(),
          TopMenus(),
          PopularFoodsWidget(),
          BestFoodWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
  // Get device token to get push notification.
  Future getDeviceToken() async {
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? '' : deviceToken;
  }
}