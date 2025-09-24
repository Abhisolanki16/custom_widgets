import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppNavigator {
  /// Opens phone dialer with given number
  static Future<void> openDialer(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await _launch(uri);
  }

  /// Opens WhatsApp chat
  static Future<void> openWhatsApp(
    String phoneNumber, {
    String? message,
  }) async {
    final String encodedMsg = Uri.encodeComponent(message ?? "");
    final Uri whatsappUri = Uri.parse(
      "whatsapp://send?phone=$phoneNumber&text=$encodedMsg",
    );
    final Uri whatsappWebUri = Uri.parse(
      "https://wa.me/$phoneNumber?text=$encodedMsg",
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(whatsappWebUri)) {
      // Fallback → opens WhatsApp Web or redirects to app if installed
      await launchUrl(whatsappWebUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("⚠️ WhatsApp is not installed!");
    }
  }

  /// Opens Google Maps with directions
  static Future<void> openGoogleMaps(String query) async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$query",
    );
    await _launch(uri);
  }

  /// Opens UPI apps like PhonePe/GPay/Paytm
  static Future<void> openUpiPayment({
    required String upiId,
    required String name,
    required String transactionRef,
    required String transactionNote,
    required String amount,
  }) async {
    final Uri uri = Uri.parse(
      "upi://pay?pa=$upiId&pn=$name&tr=$transactionRef&tn=$transactionNote&am=$amount&cu=INR",
    );
    await _launch(uri);
  }

  /// Generic launcher
  static Future<void> _launch(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("⚠️ Could not launch $uri");
    }
  }
}
