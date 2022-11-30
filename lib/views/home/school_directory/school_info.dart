import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/gallery.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolInfo extends StatefulWidget {
  const SchoolInfo({Key? key, required this.school}) : super(key: key);
  final SchoolDetails school;

  @override
  State<SchoolInfo> createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  late SchoolDetails school;
  GlobalKey itemKey = GlobalKey();
  GlobalKey item1Key = GlobalKey();
  GlobalKey item2Key = GlobalKey();

  Future schrollToItem(key) async {
    final context = key.currentContext;

    await Scrollable.ensureVisible(context!);
  }

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
                child: CachedImage(imageUrl: school.schoolLogo),
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
                                        schrollToItem(itemKey);
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
                                        schrollToItem(item1Key);

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
                                        schrollToItem(item2Key);

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

                              Column(
                                key: itemKey,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  school.levelOfStudy == 'Tertiary'
                                      ? const CustomText('Courses offered', needsIcon: false, color: AppColors.primaryColor)
                                      : const CustomText('Curriculums offered', needsIcon: false, textAlign: TextAlign.left, color: AppColors.primaryColor),
                                  SizedBox(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 26.0),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: school.curriculums.length,
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
                                                      school.curriculums[index].name,
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
                                ],
                              ),
                              //  end of first
                              Column(
                                key: item1Key,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  school.gallery.isEmpty
                                      ? Container()
                                      : Row(
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
                                  school.gallery.isEmpty
                                      ? Container()
                                      : Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(top: 2),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), // Image border
                                          ),
                                          child: CarouselSlider.builder(
                                            itemCount: school.gallery.length,
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
                                                        imageUrl: school.gallery[index],
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
                                              enableInfiniteScroll: school.gallery.length < 3 ? false : true,
                                              autoPlay: school.gallery.length < 3 ? false : true,
                                              autoPlayInterval: const Duration(seconds: 3),
                                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                              autoPlayCurve: Curves.fastOutSlowIn,
                                              enlargeCenterPage: false,
                                              scrollDirection: Axis.horizontal,
                                            ),
                                          ),
                                        ),
                                  const Divider(),
                                ],
                              ),
                              // end of second
                              Column(
                                key: item2Key,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    child: CustomText(school.website, color: AppColors.primaryColor, fontSize: 14, icon: Icons.circle),
                                  ),
                                ],
                              )

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