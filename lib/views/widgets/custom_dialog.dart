import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_text.dart';

class CustomDialog {
  static showCustomDialog() {
    Get.defaultDialog(
      backgroundColor: AppColors.white,
      title: '',
      radius: 9,
      titlePadding: const EdgeInsets.only(top: 8),
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.black,
        fontSize: 18,
      ),
      content: Column(
        children: const [
          CustomText(
            'Thanks!',
            fontSize: 16,
            needsIcon: false,
            color: AppColors.primaryColor,
            textAlign: TextAlign.center,
            pBottom: 0,
            pLeft: 0,
            pRight: 0,
            pTop: 0,
          ),
          SizedBox(height: 20),
          CustomText(
            'Your details have been submitted successfully!',
            fontSize: 14,
            needsIcon: false,
            textAlign: TextAlign.center,
            pBottom: 0,
            pLeft: 0,
            pRight: 0,
            pTop: 0,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
