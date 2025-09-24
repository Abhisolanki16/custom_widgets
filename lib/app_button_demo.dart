import 'package:custom_widgets/app_button.dart';
import 'package:flutter/material.dart';

class AppButtonDemo extends StatelessWidget {
  const AppButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Button Demo")),
      body: Column(
        children: [
          // Simple primary button
          AppButton(text: "Submit", onPressed: () {}),

          // Button with icon
          AppButton(
            text: "Login with Google",
            icon: Icons.login,
            backgroundColor: Colors.red,
            textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            iconColor: Colors.white,
            borderRadius: 20,
            onPressed: () {},
          ),

          // Outlined style button
          AppButton(
            text: "Cancel",
            backgroundColor: Colors.white,
            borderColor: Colors.black,
            textStyle: const TextStyle(color: Colors.black),
            onPressed: () {},
          ),

          // Loading state
          AppButton(text: "Processing...", isLoading: true, onPressed: () {}),
        ],
      ),
    );
  }
}
