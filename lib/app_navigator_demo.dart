import 'package:custom_widgets/app_navigator.dart';
import 'package:flutter/material.dart';

class AppNavigatorDemo extends StatelessWidget {
  const AppNavigatorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Navigator Demo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              AppNavigator.openDialer("9876543210");
            },
            child: const Text("Open Dialer"),
          ),

          ElevatedButton(
            onPressed: () {
              AppNavigator.openWhatsApp(
                "919876543210",
                message: "Hello from Flutter 🚀",
              );
            },
            child: const Text("WhatsApp"),
          ),

          ElevatedButton(
            onPressed: () {
              AppNavigator.openGoogleMaps("India Gate, Delhi");
            },
            child: const Text("Google Maps"),
          ),

          ElevatedButton(
            onPressed: () {
              AppNavigator.openUpiPayment(
                upiId: "test@upi",
                name: "Test User",
                transactionRef: "TID123456",
                transactionNote: "Payment for order",
                amount: "100.00",
              );
            },
            child: const Text("Pay with UPI"),
          ),
        ],
      ),
    );
  }
}
