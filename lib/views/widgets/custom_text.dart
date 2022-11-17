import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.fontSize = 16,
    this.color = AppColors.black,
    this.icon = Icons.abc,
    this.needsIcon = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.pLeft = 26,
    this.pBottom = 12,
    this.pRight = 0,
    this.pTop = 2,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;
  final IconData icon;
  final bool needsIcon;
  final MainAxisAlignment mainAxisAlignment;
  final double pLeft;
  final double pRight;
  final double pBottom;
  final double pTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: pLeft, top: pTop, bottom: pBottom, right: pRight),
      child: needsIcon
          ? Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            )
          : Text(
              text,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
            ),
    );
  }
}
