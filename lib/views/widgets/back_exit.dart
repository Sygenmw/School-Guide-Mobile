import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';

class Exitable extends StatelessWidget {
  final Widget child;

  const Exitable({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      backgroundRadius: 7,
      message: 'Press Again to Exit',
      background: AppColors.primaryColor,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
      child: child,
    );
  }
}
