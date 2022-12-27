import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.controllers, required this.onTap});

  final List<TextEditingController> controllers;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        height: 40,
        width: Get.size.width / 3,
        margin: const EdgeInsets.only(left: 60, right: 60),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Material(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              controllers.forEach((controller) {
                if (controller.text.trim().isNotEmpty) {
                  HapticFeedback.vibrate();

                  onTap();
                } else {}
              });
              CustomSnackBar.showSnackBar(message: 'One or more fields look empty', title: 'Error!', color: AppColors.errorColor);
            },
            child: Center(
              child: CustomText(
                'Send',
                pLeft: 0,
                pTop: 0,
                pBottom: 0,
                pRight: 0,
                color: AppColors.white,
                needsIcon: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
