// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/featured_carousel_controller.dart';
import 'package:school_guide/models/banner.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog/edu_blog_details.dart';
import 'package:school_guide/views/home/school_directory/school_details.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCarousel extends StatelessWidget {
  HomeCarousel({Key? key}) : super(key: key);
  late FeaturedItems items = FeaturedItems();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BannerDetails>>(
        stream: getAllBanners(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BannerDetails> banners = snapshot.data!;
            List<BannerDetails> validBanners = [];

            for (var banner in banners) {
              if (banner.dateLine.compareTo(Timestamp.now()) > 0) {
                validBanners.add(banner);
              } else {
                // print('in else');
              }
            }

            return validBanners.isEmpty
                ? Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                      'https://th.bing.com/th/id/R.b502cd29aed436797c011142ca531565?rik=cmFu6HN4%2fm2RTQ&pid=ImgRaw&r=0',
                      fit: BoxFit.cover,
                    ),
                  )
                : CarouselSlider.builder(
                    itemCount: validBanners.length,
                    itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                      // final diff = DateTime.now().difference(TimeConversion.convertToDateTime(banners[index].dateLine));
                      // print(diff);
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: validBanners[index].linkType == 'External'
                              ? () {
                                  launchUrl(Uri.parse(banners[index].bannerLink), mode: LaunchMode.externalApplication);
                                }
                              : () {
                                  Get.to(() => const SchoolInfo());
                                },
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                banners[index].bannerImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Container();
        });
  }

  // Get all the banners
  Stream<List<BannerDetails>> getAllBanners() {
    return FirebaseFirestore.instance.collection('banners').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => BannerDetails.fromDocument(doc)).toList());
  }
}

class EduCarousel extends StatelessWidget {
  EduCarousel({Key? key}) : super(key: key);
  late FeaturedItems items = FeaturedItems();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: items.featuredItems.length,
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const EduBlogDetails());
            },
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.network(
                        items.featuredItems[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Digital Library Malawi',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16),
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(4),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.bookmark_add_outlined,
                                          color: AppColors.primaryColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: Text('If you can read this correctly without doing any jiggling it means you are sicksssss'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
