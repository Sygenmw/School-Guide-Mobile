// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.height - 100);
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
                            'The mobile app was developed to simplify the search for private schools in Malawi. Apart from having information on private schools across the warm heart of Africa, we have also included scholarships and articles tailored for Malawian students.'),
                    AboutText(title: 'The Developers', description: 'The app was designed and build with love by Sygen, a tech startup that develops mobile, web and desktop systems.'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: rowIcons,
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
                    SizedBox(height: 2),
                  ],
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Text(
                        'More apps on',
                        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://play.google.com/store/apps/dev?id=6364907402463387951&hl=en&gl=US'), mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        // width: double.infinity,
                        color: AppColors.grey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: CachedImage(
                                  imageUrl: 'https://logos-world.net/wp-content/uploads/2020/11/Google-Play-Logo.png',
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
    );
  }

  List<Widget> rowIcons = [
    buildRowIcon(icon: FontAwesomeIcons.youtube, link: 'https://www.youtube.com/@sygen8722'),
    buildRowIcon(icon: FontAwesomeIcons.phone, link: 'tel:+265880012674'),
    buildRowIcon(icon: Icons.mail_outline, link: 'mailto:info@sygenmw.com'),
    buildRowIcon(icon: FontAwesomeIcons.linkedin, link: 'https://www.linkedin.com/in/sygen'),
    buildRowIcon(icon: FontAwesomeIcons.facebook, link: 'https://web.facebook.com/sygenmw'),
    buildRowIcon(icon: FontAwesomeIcons.instagram, link: 'https://instagram.com/sygenmw/'),
  ];
}

buildRowIcon({required String link, required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
        },
        child: CircleAvatar(radius: 20, backgroundColor: AppColors.white, child: Icon(icon, color: AppColors.primaryColor))),
  );
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
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w900),
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
