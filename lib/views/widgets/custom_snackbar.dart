import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';

class CustomSnackBar {
  static void showSnackBar({String? title, String? message, Color color = AppColors.primaryColor}) {
    Get.snackbar(
      '',
      '',
      duration: const Duration(
        seconds: 3,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      margin: const EdgeInsets.all(12),
      titleText: Text(
        title!.toUpperCase(),
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}