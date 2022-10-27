import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.onPressed,
    required this.items,
    required this.image,
    required this.title,
    required this.isSmall,
    this.needDots = true,
  }) : super(key: key);

  final VoidCallback onPressed;
  final List items;
  final String image;
  final String title;
  final bool isSmall;
  final bool needDots;

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Container(
      constraints: isSmall ? BoxConstraints(minHeight: 100, maxHeight: 150, minWidth: size.width / 2.3) : BoxConstraints(minHeight: 200, maxHeight: 220, minWidth: size.width / 2.3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor,
      ),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            HapticFeedback.vibrate();
            onPressed();
          },
          onLongPress: () {
            HapticFeedback.vibrate();
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircleAvatar(radius: 30, backgroundColor: AppColors.primaryColor, backgroundImage: AssetImage(image)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...items.map(
                        (text) => Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Row(
                            children: needDots
                                ? [
                                    const Icon(
                                      Icons.fiber_manual_record,
                                      size: 8,
                                      color: AppColors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        text,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ]
                                : [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        text,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
