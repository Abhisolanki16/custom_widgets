import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // ===== Predefined Weights =====
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  /// Create a custom text style
  static TextStyle custom({
    double size = 16,
    FontWeight weight = FontWeight.w400,
    Color color = Colors.black,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return TextStyle(
      fontSize: size.spMin,
      fontWeight: weight,
      color: color,
      overflow: overflow,
    );
  }

  // ===== Regular =====
  static TextStyle regular16 = TextStyle(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle regular18 = TextStyle(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle regular20 = TextStyle(
    fontSize: 20.spMin,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle regular22 = TextStyle(
    fontSize: 22.spMin,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  // ===== Medium =====
  static TextStyle medium16 = TextStyle(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle medium18 = TextStyle(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle medium20 = TextStyle(
    fontSize: 20.spMin,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle medium22 = TextStyle(
    fontSize: 22.spMin,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  // ===== Semi-Bold =====
  static TextStyle semiBold16 = TextStyle(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle semiBold18 = TextStyle(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle semiBold20 = TextStyle(
    fontSize: 20.spMin,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle semiBold22 = TextStyle(
    fontSize: 22.spMin,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  // ===== Bold =====
  static TextStyle bold16 = TextStyle(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle bold18 = TextStyle(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle bold20 = TextStyle(
    fontSize: 20.spMin,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle bold22 = TextStyle(
    fontSize: 22.spMin,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    overflow: TextOverflow.ellipsis,
  );
}
