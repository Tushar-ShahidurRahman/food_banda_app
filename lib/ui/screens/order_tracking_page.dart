import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_banda_app/ui/utils/app_color.dart';


import 'package:flutter/material.dart';

class OrderTrackingPage extends StatefulWidget {
  final String role; // Buyer or Seller

  OrderTrackingPage({required this.role});

  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  bool get isBuyer => widget.role == 'Buyer';
  int _timerDuration = 1200; // 20 minutes in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if (isBuyer) {
      startTimer();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        //  perform the necessary actions when the order is
          //  canceled, such as updating the order status or notifying the user.
        } else {
          _timer.cancel();
          // Perform order cancellation logic here
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        title: const Text('Order tracking page', style: TextStyle(color: greyColor),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Order Status',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3a3a3b),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pending', // Replace with actual order status
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3a3a3b),
              ),
            ),
            if (isBuyer) const SizedBox(height: 40),
            if (isBuyer) ...[
              const Text(
                'Countdown Timer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3a3a3b),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                formatDuration(Duration(seconds: _timerDuration)),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3a3a3b),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}





// class OrderTrackingPage extends StatefulWidget {
//   @override
//   _OrderTrackingPageState createState() => _OrderTrackingPageState();
// }
//
// class _OrderTrackingPageState extends State<OrderTrackingPage> {
//   int _timerDuration = 30; // Set the initial countdown duration in seconds
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_timerDuration > 0) {
//           _timerDuration--;
//         } else {
//           _timer.cancel();
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFFAFAFA),
//         title: const Text('Order tracking page', style: TextStyle(color: greyColor),),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Order Status',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: redColor,
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Pending', // Replace with actual order status
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF3a3a3b),
//               ),
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Countdown Timer',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF3a3a3b),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               formatDuration(Duration(seconds: _timerDuration)),
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF3a3a3b),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String formatDuration(Duration duration) {
//     final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
//     final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }
// }
