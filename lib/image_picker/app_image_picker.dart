import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AppImagePicker {
  static final ImagePicker _picker = ImagePicker();

  /// Check and request permission
  static Future<bool> _checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;

    if (status.isGranted) return true;

    status = await permission.request();

    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  /// Pick single image from **Camera**
  static Future<File?> pickFromCamera(BuildContext context) async {
    final granted = await _checkPermission(Permission.camera);
    if (!granted) return null;

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
  }

  /// Pick single image from **Gallery**
  static Future<File?> pickSingleFromGallery(BuildContext context) async {
    final granted = await _checkPermission(Permission.photos);
    if (!granted) return null;

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  /// Pick multiple images from **Gallery**
  static Future<List<File>> pickMultipleFromGallery(
    BuildContext context,
  ) async {
    final granted = await _checkPermission(Permission.photos);
    if (!granted) return [];

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result == null) return [];
    return result.paths.map((path) => File(path!)).toList();
  }

  /// Show custom dialog when permission denied
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
