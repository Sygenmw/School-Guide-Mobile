import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class AboutUs extends StatelessWidget {
  AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.height - 105);
    double bRadius = 40;
    return Scaffold(
      appBar: CustomAppBar(
        showAbout: true,
        backIconAvailable: true,
      ),
      body: CustomBody(
        hPadding: 0,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'About Us',
              style: TextStyle(fontSize: 30, fontFamily: 'richard', fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: Get.size.height - Get.size.height / 2.878,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bRadius),
                  topRight: Radius.circular(bRadius),
                ),
                color: AppColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AboutText(
                        title: 'The App',
                        description:
                            'Gaza Man Crazy, we insane but we know what we are doing. Gaza Man Crazy, we insane but we know what we are doing. Gaza Man Crazy, we insane but we know what we  '),
                    AboutText(
                        title: 'The Developers',
                        description:
                            'Gaza Man Crazy, we insane but we know what we are doing. In any way things will be betterGaza Man Crazy, we insane but we know what we are doing. In any way things will be  In any way things will be better'),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: rowIcons,
                      ),
                    ),
                    AboutText(title: 'Physical Address', description: 'Masauko Chipembere Highway\nCity Plaza, Room 4,\nBlantyre Malawi.'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 100,
                        child: Image.asset(
                          'assets/images/sygen_logo.png',
                          color: AppColors.white,
                        )),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  List<Widget> rowIcons = [
    Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(onTap: () {}, child: CircleAvatar(radius: 20, backgroundColor: AppColors.white, child: Icon(Icons.play_arrow, color: AppColors.primaryColor))),
    ),
    Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(onTap: () {}, child: CircleAvatar(radius: 20, backgroundColor: AppColors.white, child: Icon(Icons.phone, color: AppColors.primaryColor))),
    ),
    Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(onTap: () {}, child: CircleAvatar(radius: 20, backgroundColor: AppColors.white, child: Icon(Icons.mail_outline, color: AppColors.primaryColor))),
    ),
    Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(onTap: () {}, child: CircleAvatar(radius: 20, backgroundColor: AppColors.white, child: Icon(Icons.facebook_outlined, color: AppColors.primaryColor))),
    ),
    Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(onTap: () {}, child: CircleAvatar(radius: 20, backgroundColor: AppColors.white, child: Icon(Icons.web, color: AppColors.primaryColor))),
    ),
    Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(onTap: () {}, child: CircleAvatar(radius: 20, backgroundColor: AppColors.white, child: Icon(Icons.play_arrow, color: AppColors.primaryColor))),
    ),
  ];
}

class AboutText extends StatelessWidget {
  const AboutText({super.key, required this.title, required this.description});
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontFamily: 'leguespartan'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
