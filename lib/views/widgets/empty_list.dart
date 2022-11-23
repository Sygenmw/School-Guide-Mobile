import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_text.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, this.text = 'No items match your filter!'});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImages.logo))),
          ),
          CustomText(text, textAlign: TextAlign.center, needsIcon: false, color: Colors.black38)
        ],
      ),
    );
  }
}
