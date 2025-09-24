import 'dart:io';
import 'package:custom_widgets/permission/app_permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_image_picker.dart';

class ImagePickerDemo extends StatefulWidget {
  const ImagePickerDemo({super.key});

  @override
  State<ImagePickerDemo> createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  File? _singleImage;
  List<File> _multipleImages = [];

  Future<void> _pickCamera() async {
    bool granted = await AppPermissionHandler.requestPermission(
      Permission.camera,
    );
    if (granted) {
      final img = await AppImagePicker.pickFromCamera(context);
      if (img != null) setState(() => _singleImage = img);
    }
  }

  Future<void> _pickSingleGallery() async {
    bool granted = await AppPermissionHandler.requestPermission(
      Permission.camera,
    );
    if (granted) {
      final img = await AppImagePicker.pickSingleFromGallery(context);
      if (img != null) setState(() => _singleImage = img);
    }
  }

  Future<void> _pickMultipleGallery() async {
    bool granted = await AppPermissionHandler.requestPermission(
      Permission.camera,
    );
    if (granted) {
      final imgs = await AppImagePicker.pickMultipleFromGallery(context);
      if (imgs.isNotEmpty) setState(() => _multipleImages = imgs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker Demo")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickCamera,
              child: const Text("Pick from Camera (Single)"),
            ),
            ElevatedButton(
              onPressed: _pickSingleGallery,
              child: const Text("Pick Single from Gallery"),
            ),
            ElevatedButton(
              onPressed: _pickMultipleGallery,
              child: const Text("Pick Multiple from Gallery"),
            ),
            const SizedBox(height: 20),
            if (_singleImage != null) ...[
              const Text("Single Image:"),
              Image.file(_singleImage!, height: 200),
            ],
            if (_multipleImages.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text("Multiple Images:"),
              Wrap(
                spacing: 8,
                children: _multipleImages
                    .map(
                      (img) => Image.file(
                        img,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
