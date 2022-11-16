import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';

class TopText extends StatelessWidget {
  const TopText({Key? key, required this.text, this.fontSize = 17}) : super(key: key);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: AppColors.primaryColor),
    );
  }
}

class TopBlackText extends StatelessWidget {
  const TopBlackText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.black),
    );
  }
}
