// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/featured_carousel_controller.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog/edu_blog_details.dart';
import 'package:school_guide/views/home/school_directory/school_details.dart';

class HomeCarousel extends StatelessWidget {
  HomeCarousel({Key? key}) : super(key: key);
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
              Get.to(() => const SchoolInfo());
            },
            child: Container(
              width: 400,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  items.featuredItems[index],
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
