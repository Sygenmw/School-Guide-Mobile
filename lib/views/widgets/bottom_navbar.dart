import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:get/get.dart';
import 'package:school_guide/views/agents.dart';
import 'package:school_guide/views/tutors.dart';
import 'package:school_guide/views/homepage.dart';
import 'package:school_guide/views/menu.dart';
import 'package:school_guide/views/videos.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BottomNavItem(
                    onPressed: () {
                      HapticFeedback.vibrate();

                      Get.offAll(() => const Tutor());
                    },
                    image: AppImages.curriculum,
                    label: 'Tutors'),
              ),
              Expanded(
                child: BottomNavItem(
                    onPressed: () {
                      HapticFeedback.vibrate();

                      Get.offAll(() => const Videos());
                    },
                    image: AppImages.videos,
                    label: 'Videos'),
              ),
              Expanded(
                child: BottomNavItem(
                    onPressed: () {
                      HapticFeedback.vibrate();
                      Get.offAll(() => const Home());
                    },
                    image: AppImages.home,
                    label: 'Home'),
              ),
              Expanded(
                child: BottomNavItem(
                    onPressed: () {
                      HapticFeedback.vibrate();

                      Get.offAll(() => const Agents());
                    },
                    image: AppImages.agents,
                    label: 'Agents'),
              ),
              Expanded(
                child: BottomNavItem(
                    onPressed: () {
                      HapticFeedback.vibrate();

                      Get.offAll(() => const Menu());
                    },
                    image: AppImages.menu,
                    label: 'Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({Key? key, required this.image, required this.label, required this.onPressed}) : super(key: key);
  final String image;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          HapticFeedback.vibrate();
          onPressed();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(image),
              color: AppColors.primaryColor,
              size: 23,
            ),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                  fontSize: 12,
                )),
          ],
        ),
      ),
    );
  }
}
