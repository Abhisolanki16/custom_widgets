import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_permission_handler.dart';

class AppPermissionDemo extends StatelessWidget {
  const AppPermissionDemo({super.key});

  Future<void> _checkCameraPermission(BuildContext context) async {
    bool granted = await AppPermissionHandler.requestPermission(
      Permission.camera,
    );

    if (!granted) {
      // If not granted, show info dialog
      await AppPermissionHandler.showPermissionDialog(
        context,
        "Camera Permission Required",
        "We need camera access to take photos. Please allow it from settings.",
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera Permission Granted ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permission Handler Demo")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _checkCameraPermission(context),
          child: const Text("Check Camera Permission"),
        ),
      ),
    );
  }
}
