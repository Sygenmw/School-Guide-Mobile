import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/banner_controller.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/models/scholarship_model.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog.dart';
import 'package:school_guide/views/home/scholarships.dart';
import 'package:school_guide/views/home/school_directiory.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';
import 'package:school_guide/views/home/school_finder.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/home_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BannerController bannerController = Get.find();

  final SchoolsNearController schoolController = Get.find();

  final xgirlfriend = '';

  SchoolDetails currentSchool = SchoolDetails(
      address: '',
      city: '',
      country: '',
      createdAt: Timestamp.now(),
      details: [],
      email: '',
      phone: '',
      schoolLogo: '',
      schoolName: '',
      showInApp: false,
      status: '',
      curriculum: [],
      updatedAt: Timestamp.now(),
      website: '',
      id: '');

  getSchool() {
    for (var banner in bannerController.allBanners) {
      for (var school in schoolController.allSchools) {
        if (school.id == banner.schoolID) {
          currentSchool = school;
        }
      }
    }
  }

  @override
  void initState() {
    getSchool();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: false,
          isHomeAppBar: true,
        ),
        body: Obx(
          () => CustomBody(
            text: '',
            children: [
              bannerController.allBanners.isEmpty
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(child: Text('Loading')),
                    )
                  : CarouselSlider.builder(
                      itemCount: bannerController.allBanners.length,
                      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                        // final diff = DateTime.now().difference(TimeConversion.convertToDateTime(banners[index].dateLine));
                        // print(diff);
                        // print(bannerController.allBanners[1].linkType);
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: bannerController.allBanners[index].linkType.toLowerCase() == 'external'
                                ? () {
                                    launchUrl(Uri.parse(bannerController.allBanners[index].bannerLink), mode: LaunchMode.externalApplication);
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
                                  imageUrl: bannerController.allBanners[index].bannerImage,
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
                                var allSchools = snapshot.data!;
                                List<String> schoolNames = [];
                                for (var school in allSchools) {
                                  if (school.schoolName.length < 15) {
                                    schoolNames.add(school.schoolName);
                                  } else {
                                    schoolNames.add('${school.schoolName.substring(0, 15)}...');
                                  }
                                }
                                return HomeButton(
                                  title: 'Schools near you',
                                  image: AppImages.scholsNear,
                                  isSmall: true,
                                  items: schoolNames.length > 1 ? schoolNames.sublist(0, 2) : schoolNames,
                                  needDots: false,
                                  onPressed: () {
                                    Get.to(() => SchoolFinder());
                                  },
                                );
                              } else {
                                print(snapshot.error.toString());
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
                                  if (school.schoolName.length < 15) {
                                    schoolNames.add(school.schoolName);
                                  } else {
                                    schoolNames.add('${school.schoolName.substring(0, 15)}...');
                                  }
                                }
                                return HomeButton(
                                  title: 'School directory',
                                  image: AppImages.schoolDirectory,
                                  isSmall: false,
                                  items: schoolNames.length > 3 ? schoolNames.sublist(0, 3) : schoolNames,
                                  onPressed: () {
                                    Get.to(() => const SchoolDirectory());
                                  },
                                );
                              } else {
                                print(snapshot.error.toString());
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
                                print(snapshot.error.toString());
                              }
                              return Container();
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
                                  if (blog.postTitle.length < 15) {
                                    blogTitles.add(blog.postTitle);
                                  } else {
                                    blogTitles.add('${blog.postTitle.substring(0, 15)}...');
                                  }
                                }
                                return HomeButton(
                                  title: 'Edu blog',
                                  image: AppImages.eduBlog,
                                  isSmall: true,
                                  needDots: false,
                                  items: blogTitles.length > 1 ? blogTitles.sublist(0, 2) : blogTitles,
                                  onPressed: () {
                                    Get.to(() => const EducationBlog());
                                  },
                                );
                              } else {
                                print(snapshot.error.toString());
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
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }

  // FETCH ITEMS
  Stream<List<SchoolDetails>> _getAllSchools() {
    return FirebaseFirestore.instance.collection('schools').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => SchoolDetails.fromDocument(doc)).toList());
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
}
