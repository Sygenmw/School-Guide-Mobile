import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.onPressed,
    required this.items,
    required this.image,
    required this.title,
    required this.isSmall,
    this.school,
    this.isSchool = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final List items;
  final String image;
  final String title;
  final bool isSmall;
  final bool isSchool;
  final SchoolDetails? school;

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Container(
      constraints: isSmall ? BoxConstraints(minHeight: 140, maxHeight: 160, minWidth: size.width / 2.25) : BoxConstraints(minHeight: 200, maxHeight: 220, minWidth: size.width / 2.25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
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
                  FittedBox(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircleAvatar(radius: 25, backgroundColor: AppColors.primaryColor, backgroundImage: AssetImage(image)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...items.map(
                              (text) => Padding(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                child: InkWell(
                                  onTap: isSchool
                                      ? () {
                                          Get.to(() => SchoolInfo(school: school!));
                                        }
                                      : null,
                                  child: Row(children: [
                                    const Icon(
                                      Icons.fiber_manual_record,
                                      size: 8,
                                      color: AppColors.white,
                                    ),
                                    FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          text,
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
