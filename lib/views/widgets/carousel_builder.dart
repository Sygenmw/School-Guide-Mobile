// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog/edu_blog_details.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';

class EduCarousel extends StatelessWidget {
  const EduCarousel({Key? key, required this.blogItems, required this.deviceID, required this.addFavourite}) : super(key: key);
  final List<EduBlogDetails> blogItems;
  final String deviceID;
  final VoidCallback addFavourite;

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
                    blogViews: 12,
                    deviceID: deviceID,
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
                      child: CachedImage(
                        imageUrl: blogItems[index].postCover,
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
                                  Text(
                                    blogItems[index].postTitle.length < 30 ? blogItems[index].postTitle : blogItems[index].postTitle.substring(0, 30),
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16),
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(4),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () async {},
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
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
