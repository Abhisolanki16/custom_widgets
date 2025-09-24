import 'package:custom_widgets/app_image.dart';
import 'package:flutter/material.dart';

class AppImageDemo extends StatelessWidget {
  const AppImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Image Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Asset Image
            // Cached image with shimmer effect
            AppImage(
              path: 'https://picsum.photos/400/400',
              type: AppImageType.cached,
              height: 200,
              width: 200,
              borderRadius: BorderRadius.circular(16),
            ),

            // Network image with shimmer
            AppImage(
              path: 'https://picsum.photos/500/300',
              type: AppImageType.network,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
