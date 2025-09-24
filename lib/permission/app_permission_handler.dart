import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionHandler {
  /// Request a single permission safely
  static Future<bool> requestPermission(Permission permission) async {
    // Step 1: Check current status
    PermissionStatus status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    // Step 2: Ask for permission
    status = await permission.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Permission denied but not permanently
      // Show dialog to explain why permission is needed
      return false;
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied → open settings
      await openAppSettings();
      return false;
    }

    return false;
  }

  /// Request multiple permissions together
  static Future<Map<Permission, PermissionStatus>> requestMultiple(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }

  /// Check if permission is permanently denied
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    return await permission.isPermanentlyDenied;
  }

  /// Helper to show custom dialog when permission denied
  static Future<void> showPermissionDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(ctx),
          ),
          TextButton(
            child: const Text("Open Settings"),
            onPressed: () async {
              Navigator.pop(ctx);
              await openAppSettings();
            },
          ),
        ],
      ),
    );
  }
}
