import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_guide/controllers/banner_controller.dart';
import 'package:school_guide/controllers/location_controller.dart';
import 'package:school_guide/controllers/permission_controller.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/models/banner.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/models/scholarship_model.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/models/views_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog.dart';
import 'package:school_guide/views/home/scholarships.dart';
import 'package:school_guide/views/home/school_directiory.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';
import 'package:school_guide/views/home/school_finder.dart';
import 'package:school_guide/views/menu/advertise_school.dart';
import 'package:school_guide/views/widgets/back_exit.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/home_button.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BannerController bannerController = Get.find();

  final SchoolsNearController schoolController = Get.find();

  SchoolDetails currentSchool = SchoolDetails(
      address: '',
      city: '',
      country: '',
      gallery: [],
      email: '',
      phone: '',
      header: '',
      levelOfStudy: '',
      schoolLogo: '',
      schoolName: '',
      destination: '',
      showInApp: false,
      status: '',
      curriculums: [],
      premiumFeatures: [],
      website: '',
      id: '',
      location: Location(lat: 0.0, lng: 0.0));

  List<BannerDetails> banners = [];
// CAN WE DO THIS?
  double lat = 0;
  double long = 0;
  double distance = 0.0;
  List<SchoolDetails> schoolsNearMe = [];
  void initState() {
    PermissionHandler.askLocationPermission();

    PermissionHandler.askLocationPermission();

    Timer.periodic(const Duration(seconds: 5), (xxx) {
      getGeoPoint();
      schoolController.allSchools.forEach((school) {
        if (school.showInApp && school.status.toLowerCase() == "Paid".toLowerCase()) {
          distance = calculateDistance(
            source: LatLng(school.location.lat, school.location.lng),
            dest: LatLng(lat, long),
          );
          if (distance <= 20) {
            schoolsNearMe.contains(school) ? {} : schoolsNearMe.add(school);
          }
        }
      });
    });
    super.initState();
  }

  getGeoPoint() {
    var currentLocation = LocationController().determinePosition();
    currentLocation.then((value) => {
          setState(() {
            lat = value.latitude;
            long = value.longitude;
          })
        });
  }

  double calculateDistance({required LatLng source, required LatLng dest}) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((dest.latitude - source.latitude) * p) / 2 + cos(source.latitude * p) * cos(dest.latitude * p) * (1 - cos((dest.longitude - source.longitude) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

// WE CAN DO THIS

  @override
  void dispose() {
    getGeoPoint();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Exitable(
      child: Scaffold(
          appBar: const CustomAppBar(
            backIconAvailable: false,
            isHomeAppBar: true,
          ),
          body: CustomBody(
            text: '',
            needsHeader: false,
            children: [
              StreamBuilder<List<BannerDetails>>(
                stream: _getAllBanners(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    List<BannerDetails> banners = snapshot.data!;
                    List<BannerDetails> allBanners = [];
                    banners.forEach((banner) {
                      if (banner.deadline.compareTo(Timestamp.now()) > 0) {
                        allBanners.add(banner);
                      } else {}
                    });

                    getSchool() {
                      for (var banner in allBanners) {
                        for (var school in schoolController.allSchools) {
                          if (school.id == banner.schoolID && school.showInApp) {
                            currentSchool = school;
                          }
                        }
                      }
                    }

                    getSchool();
                    return allBanners.isEmpty
                        ? Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                                onTap: () {
                                  Get.to(() => AdvertiseSchool());
                                },
                                child: ClipRRect(clipBehavior: Clip.antiAlias, borderRadius: BorderRadius.circular(8), child: Image.asset(AppImages.advertise, fit: BoxFit.cover, height: 180))),
                          )
                        : CarouselSlider.builder(
                            itemCount: allBanners.length,
                            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: allBanners[index].linkType.toLowerCase() == 'external'
                                      ? () {
                                          launchUrl(Uri.parse(allBanners[index].bannerLink), mode: LaunchMode.externalApplication);
                                        }
                                      : () {
                                          Get.to(() => SchoolInfo(school: currentSchool));
                                        },
                                  child: Container(
                                    width: 420,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedImage(
                                        imageUrl: allBanners[index].bannerImage,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16 / 9,
                              viewportFraction: allBanners.length <= 2 ? 1 : 0.856,
                              initialPage: 0,
                              enableInfiniteScroll: allBanners.length <= 1 ? false : true,
                              autoPlay: allBanners.length <= 1 ? false : true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: allBanners.length <= 2 ? false : true,
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                  }
                  return Container(
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => AdvertiseSchool());
                        },
                        child: ClipRRect(clipBehavior: Clip.antiAlias, borderRadius: BorderRadius.circular(8), child: Image.asset(AppImages.advertise, fit: BoxFit.cover, height: 180))),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        StreamBuilder<List<SchoolDetails>>(
                            stream: _getAllSchools(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<String> schoolNames = [];
                                for (var school in schoolsNearMe) {
                                  if (school.showInApp && school.status.toLowerCase() == "Paid".toLowerCase()) {
                                    if (school.schoolName.length < 15) {
                                      schoolNames.add(school.schoolName);
                                    } else {
                                      schoolNames.add('${school.schoolName.substring(0, 15)}...');
                                    }
                                  }
                                }
                                return HomeButton(
                                  title: 'Schools near you',
                                  image: AppImages.scholsNear,
                                  isSmall: true,
                                  items: schoolNames.length > 1 ? schoolNames.sublist(0, 2) : schoolNames,
                                  onPressed: () {
                                    Get.to(() => SchoolFinder(schools: schoolsNearMe));
                                  },
                                );
                              }
                              return Container();
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<List<SchoolDetails>>(
                            stream: _getAllSchools(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var allSchools = snapshot.data!;
                                List<String> schoolNames = [];
                                for (var school in allSchools) {
                                  if (school.showInApp && school.status.toLowerCase() == "Paid".toLowerCase()) {
                                    school.premiumFeatures.forEach((premiumFeature) {
                                      if (premiumFeature.feature == 'schoolOnHome' && premiumFeature.endDate.compareTo(Timestamp.now()) > 0) {
                                        if (school.schoolName.length < 15) {
                                          schoolNames.add(school.schoolName);
                                        } else {
                                          schoolNames.add('${school.schoolName.substring(0, 15)}...');
                                        }
                                      }
                                    });
                                  }
                                }
                                return HomeButton(
                                  title: 'Schools directory',
                                  image: AppImages.schoolDirectory,
                                  isSmall: false,
                                  items: schoolNames.length > 3
                                      ? schoolNames.sublist(0, 3)
                                      : schoolNames.isEmpty
                                          ? ['View all schools']
                                          : schoolNames,
                                  onPressed: () {
                                    Get.to(() => const SchoolDirectory());
                                  },
                                );
                              }
                              return Container();
                            }),
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
                        StreamBuilder<List<ScholarshipDetails>>(
                            stream: _getAllScholarships(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var allScholarships = snapshot.data!;
                                List<String> scholarshipNames = [];
                                for (var scholarship in allScholarships) {
                                  if (scholarship.scholarshipName.length < 15) {
                                    scholarshipNames.add(scholarship.scholarshipName);
                                  } else {
                                    scholarshipNames.add('${scholarship.scholarshipName.substring(0, 15)}...');
                                  }
                                }
                                return HomeButton(
                                  title: 'Scholarships',
                                  image: AppImages.scholarships,
                                  isSmall: false,
                                  items: scholarshipNames.length > 3 ? scholarshipNames.sublist(0, 3) : scholarshipNames,
                                  onPressed: () {
                                    Get.to(() => const Scholarships());
                                  },
                                );
                              } else {
                                return Container();
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<List<EduBlogDetails>>(
                            stream: _getAllBlogs(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var allBlogs = snapshot.data!;
                                List<String> blogTitles = [];
                                for (var blog in allBlogs) {
                                  if (blog.publishPost) {
                                    if (blog.postTitle.length < 15) {
                                      blogTitles.add(blog.postTitle);
                                    } else {
                                      blogTitles.add('${blog.postTitle.substring(0, 15)}...');
                                    }
                                  }
                                }
                                return HomeButton(
                                  title: 'Edu blog',
                                  image: AppImages.eduBlog,
                                  isSmall: true,
                                  items: blogTitles.length > 1 ? blogTitles.sublist(0, 1) : blogTitles,
                                  onPressed: () {
                                    Get.to(() => const EducationBlog());
                                  },
                                );
                              }
                              return Container();
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<ViewDetails>>(
                  stream: _getAllSchoolViews(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<SchoolDetails> mostViewed = [];
                      List<ViewDetails> viewDetails = snapshot.data!;
                      List<ViewDetails> viewDets = [];

                      for (var school in schoolController.allSchools) {
                        if (school.showInApp && school.status.toLowerCase() == "Paid".toLowerCase()) {
                          viewDetails.forEach((viewDetail) {
                            if (viewDetail.id == school.id) {
                              if (viewDetail.views > 1) {
                                viewDets.add(viewDetail);
                                mostViewed.contains(school) ? {} : mostViewed.add(school);
                              }
                            }
                          });
                        }
                      }
                      return mostViewed.isEmpty && mostViewed.length < 50
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TopBlackText(text: 'Most viewed'),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Container(
                                    height: 35,
                                    child: CarouselSlider.builder(
                                      itemCount: mostViewed.length,
                                      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                                        return Material(
                                          borderRadius: BorderRadius.circular(8),
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(() => SchoolInfo(school: mostViewed[index]));
                                            },
                                            borderRadius: BorderRadius.circular(8),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(
                                                        color: AppColors.primaryColor,
                                                      )),
                                                  child: Center(
                                                      child: Text(
                                                          '${mostViewed[index].schoolName.length < 25 ? mostViewed[index].schoolName : mostViewed[index].schoolName.substring(0, 25)} - ${viewDets[index].views} views',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(color: AppColors.primaryColor))),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        height: 35,
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 0.66,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 5),
                                        autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: false,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                    } else
                      return Container();
                  })
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2)),
    );
  }

  // FETCH ITEMS
  Stream<List<SchoolDetails>> _getAllSchools() {
    return FirebaseFirestore.instance.collection('schools').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => SchoolDetails.fromDocument(doc)).toList());
  }

  Stream<List<ViewDetails>> _getAllSchoolViews() {
    return FirebaseFirestore.instance.collection('schoolViews').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => ViewDetails.fromDocument(doc)).toList());
  }

  Stream<List<ScholarshipDetails>> _getAllScholarships() {
    return FirebaseFirestore.instance
        .collection('scholarships')
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => ScholarshipDetails.fromDocument(doc)).toList());
  }

  Stream<List<EduBlogDetails>> _getAllBlogs() {
    return FirebaseFirestore.instance.collection('eduBlog').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => EduBlogDetails.fromDocument(doc)).toList());
  }

  Stream<List<BannerDetails>> _getAllBanners() {
    return FirebaseFirestore.instance.collection('banners').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => BannerDetails.fromDocument(doc)).toList());
  }
}
