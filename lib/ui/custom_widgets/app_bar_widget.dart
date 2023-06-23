import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(8),

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
              ],

            ),
            child: Icon(Icons.menu),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(8),

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
              ],

            ),
            child: Icon(Icons.notifications),
          ),
        )
      ]),
    );
  }
}
