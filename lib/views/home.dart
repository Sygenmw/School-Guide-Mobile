import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog.dart';
import 'package:school_guide/views/home/scholarships.dart';
import 'package:school_guide/views/home/school_directiory.dart';
import 'package:school_guide/views/home/school_finder.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/carousel_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/home_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: false,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: '',
          children: [
            HomeCarousel(),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      HomeButton(
                        title: 'Schools near you',
                        image: AppImages.scholsNear,
                        isSmall: true,
                        needDots: false,
                        items: const ['Akins International'],
                        onPressed: () {
                          Get.to(() => const SchoolFinder());
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      HomeButton(
                        title: 'School directory',
                        image: AppImages.schoolDirectory,
                        isSmall: false,
                        items: const ['Akins International', 'Bedir Primary', 'Access Academy'],
                        onPressed: () {
                          Get.to(() => const SchoolDirectory());
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Column(
                    children: [
                      HomeButton(
                        title: 'Scholarships',
                        image: AppImages.scholarships,
                        isSmall: false,
                        items: const ['FCB', 'Japanese Gov.', 'FDH'],
                        onPressed: () {
                          Get.to(() => const Scholarships());
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      HomeButton(
                        title: 'Edu blog',
                        image: AppImages.eduBlog,
                        isSmall: true,
                        needDots: false,
                        items: const [
                          'How to Apply..',
                        ],
                        onPressed: () {
                          Get.to(() => const EducationBlog());
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
