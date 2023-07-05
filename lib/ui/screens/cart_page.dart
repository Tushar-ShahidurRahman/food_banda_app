// import 'package:ecommerce_app_cbay/ui_presentation_layer/ui_state_manager/bottom_navigation_bar_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../custom_widgets/cart_related_widgets/cart_item_widget.dart';
// import '../custom_widgets/common_elevated_button.dart';
import '../custom_widgets/cart_related_widgets/cart_item_widget.dart';
import '../utils/app_color.dart';
// import '../utils/styles.dart';

class CartPage extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productImage;
  final String productCartQuantity;

  const CartPage(
      {Key? key,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.productCartQuantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
            onPressed: () {
              // Get.find<BottomNavigationBarController>().goToHomePage();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  productName: 'Dummy name',
                  productCartQuantity: '01',
                  productImage: "assets/images/popular_foods/$productImage.png",
                  // productImage:
                  //     "assets/images/popular_foods/ic_popular_food_1.png",
                  productPrice: 'Dummy price',
                );
              },
            ),
          ),
          Container(
            // height: 90,
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(.15),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )),

            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Price",
                        // style: screenTitleTextStyle.copyWith(
                        //     color: greyColor, fontSize: 16),
                      ),
                      // if(price?.isNotEmpty) {
                      Text(
                        '\$500',
                        // style: screenTitleTextStyle.copyWith(
                        //   color: primaryColor,
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w600,
                        // ),
                      ),
                      // }
                    ],
                  ),
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Check out')),
                    // CommonElevatedButton(title: 'Check out', onTap: () {}),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
