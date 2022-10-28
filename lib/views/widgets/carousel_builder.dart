// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/all_controllers.dart';
import 'package:school_guide/models/banner.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog/edu_blog_details.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key}) : super(key: key);

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final BannerController bannerController = Get.find();

  List<BannerDetails> validBanners = [];

  void getBanners() {
    for (var banner in bannerController.allBanners) {
      if (banner.dateLine.compareTo(Timestamp.now()) > 0) {
        validBanners.add(banner);
        print('NOT YET DATELINE : ${banner.dateLine.compareTo(Timestamp.now())}');
      } else {
        print('Dateline Passed${banner.dateLine.compareTo(Timestamp.now())}');
      }
    }
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return validBanners.isEmpty
        ? Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(child: Text('Loading')),
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
                          launchUrl(Uri.parse(validBanners[index].bannerLink), mode: LaunchMode.externalApplication);
                        }
                      : () {
                          // Get.to(() => const SchoolInfo());
                        },
                  child: Container(
                    width: 420,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: bannerController.allBanners[index].bannerImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.black,
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                  // color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 220,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          );
  }
}

class EduCarousel extends StatelessWidget {
  const EduCarousel({Key? key, required this.blogItems}) : super(key: key);
  final List<EduBlogDetails> blogItems;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: blogItems.length,
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              Get.to(() => EduBlogItemDetails(
                    eduBlog: blogItems[index],
                  ));
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
                      child: CachedNetworkImage(
                        imageUrl: blogItems[index].postCover,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.black,
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                  // color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
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
                                  Text(
                                    blogItems[index].postTitle,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16),
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
                              Expanded(
                                child: Text(blogItems[index].postDescription),
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
