import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolInfo extends StatefulWidget {
  const SchoolInfo({Key? key, required this.school}) : super(key: key);
  final SchoolDetails school;

  @override
  State<SchoolInfo> createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  late SchoolDetails school;

  @override
  void initState() {
    school = widget.school;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _showBottomSheet(context);
    // });
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: school.schoolName,
                child: CachedImage(
                  imageUrl: school.schoolLogo,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(150),
                    child: CachedImage(
                      imageUrl: school.schoolLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: Get.size.height,
                  child: DraggableScrollableSheet(
                    expand: true,
                    minChildSize: 0.12,
                    maxChildSize: 0.79,
                    initialChildSize: 0.345,

                    // snap: true,
                    builder: (BuildContext context, ScrollController scrollController) {
                      return Card(
                        margin: const EdgeInsets.all(0),
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    height: 5,
                                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.only(top: 2.0),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        HapticFeedback.vibrate();
                                        // controller.scrollToIndex(5, preferPosition: AutoScrollPosition.begin);
                                      },
                                      child: Image.asset(
                                        AppImages.infoHand,
                                        height: 36,
                                        width: 36,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        HapticFeedback.vibrate();
                                        // controller.scrollToIndex(13, preferPosition: AutoScrollPosition.begin);

                                        // print('');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Image.asset(
                                          AppImages.gallery,
                                          height: 36,
                                          width: 36,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        HapticFeedback.vibrate();
                                        // controller.scrollToIndex(16, preferPosition: AutoScrollPosition.begin);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Image.asset(
                                          AppImages.contactUs,
                                          height: 36,
                                          width: 36,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  school.schoolName.toUpperCase(),
                                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                ),
                              )),
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.infoHand,
                                    height: 20,
                                    width: 20,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'School info',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              CustomText(
                                school.city,
                                icon: Icons.location_city,
                                fontSize: 14,
                              ),
                              Column(
                                children: [
                                  CustomText(school.address.length < 40 ? school.address : school.address.substring(0, 40), fontSize: 14, icon: Icons.maps_home_work),
                                ],
                              ),
                              CustomText(school.country, fontSize: 14, icon: Icons.map),
                              const CustomText('Curriculums offered', needsIcon: false, color: AppColors.primaryColor),
                              SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 26.0),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: school.curriculum.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 4.0,
                                            top: 4.0,
                                            bottom: 4.0,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              child: Center(
                                                child: Text(
                                                  school.curriculum[index],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              const Divider(),
                              //  end of first
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.gallery,
                                    height: 20,
                                    width: 20,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Gallery',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 70,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), // Image border
                                ),
                                child: CarouselSlider.builder(
                                  itemCount: 6,
                                  itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => DisplayGallery(imageIndex: index, title: school.schoolName, school: school));
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 60,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: school.schoolLogo,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: 128,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.3,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    autoPlay: true,
                                    autoPlayInterval: const Duration(seconds: 3),
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                              const Divider(),
                              // end of second
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.contactUs,
                                    height: 20,
                                    width: 20,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'About Us',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  String subject = 'INQUIRY';
                                  String body = 'Hello, ${school.schoolName}, I wanted ...';
                                  String query = 'mailto:${school.email}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
                                  launchUrl(Uri.parse(query));
                                  // launchUrl(Uri.parse(school.email), mode: LaunchMode.externalApplication);
                                },
                                child: CustomText(school.email, fontSize: 14, icon: Icons.email),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse('tel:${school.phone}'), mode: LaunchMode.externalApplication);
                                },
                                child: CustomText(school.phone, fontSize: 14, icon: Icons.phone_android),
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  launchUrl(Uri.parse(school.website), mode: LaunchMode.externalApplication);
                                },
                                child: CustomText(school.website, fontSize: 14, icon: Icons.circle),
                              ),

                              //  end of third
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}

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

class DisplayGallery extends StatelessWidget {
  const DisplayGallery({Key? key, this.title, this.school, required this.imageIndex}) : super(key: key);
  final String? title;
  final SchoolDetails? school;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    var controller = PageController(keepPage: true, initialPage: imageIndex);

    return Scaffold(
      appBar: const CustomAppBar(backIconAvailable: true, showAbout: true, isHomeAppBar: true),
      body: PageView.builder(
          controller: controller,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: InteractiveViewer(
                      panEnabled: false,
                      boundaryMargin: const EdgeInsets.all(2),
                      minScale: 0.5,
                      maxScale: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: school!.schoolLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 15,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${index + 1} / 6',
                        style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
