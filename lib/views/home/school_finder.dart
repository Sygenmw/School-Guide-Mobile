import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_guide/controllers/location_controller.dart';
import 'package:school_guide/controllers/permission_controller.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/school_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

import '../widgets/custom_body.dart';

class SchoolFinder extends StatefulWidget {
  SchoolFinder({Key? key, required this.schools}) : super(key: key);
  final List<SchoolDetails> schools;

  @override
  State<SchoolFinder> createState() => _SchoolFinderState();
}

//WARNING BAD CODE AHEAD

class _SchoolFinderState extends State<SchoolFinder> {
  final SchoolsNearController schoolController = Get.find();
  int? destinationSelectedIndex = 0;

  int? levelSelectedIndex = 0;
  int? curriculumSelectedIndex = 0;

  List selectedSchools = [];

  void getSchools({required String level}) {
    selectedSchools.clear();
    schoolsNearMe.forEach((school) {
      if (school.levelOfStudy.toLowerCase() == level.toLowerCase()) {
        setState(() {
          selectedSchools.add(school);
        });
      }
    });
  }

  double lat = 0;
  double long = 0;
  double distance = 0.0;
  List<SchoolDetails> schoolsNearMe = [];
  Timer time = Timer(Duration(seconds: 0), () {});
  void initState() {
    PermissionHandler.askLocationPermission();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getGeoPoint();
      schoolController.allSchools.forEach((school) {
        distance = calculateDistance(
          source: LatLng(school.location.lat, school.location.lng),
          dest: LatLng(
            lat,
            long,
          ),
        );
        if (distance <= 20) {
          schoolsNearMe.contains(school) ? {} : schoolsNearMe.add(school);
        }
      });
      time = timer;
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

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backIconAvailable: true,
        isHomeAppBar: true,
      ),
      body: CustomBody(
        needsHeader: true,
        text: 'Schools near me',
        children: [
          TopBlackText(text: 'LEVEL OF STUDY'),
          SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: levels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 4.0,
                      top: 4.0,
                      bottom: 4.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        setState(() {
                          levelSelectedIndex = index;
                        });
                        getSchools(level: levels.elementAt(levelSelectedIndex!));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: levelSelectedIndex == index ? AppColors.primaryColor : AppColors.white,
                          border: Border.all(color: levelSelectedIndex != index ? AppColors.primaryColor : Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Center(
                            child: Text(
                              levels[index],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: levelSelectedIndex == index ? AppColors.white : AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          levelSelectedIndex == 0
              ? schoolsNearMe.isEmpty
                  ? Container(
                      height: Get.size.height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImages.logo))),
                          ),
                          CustomText('fetching schools near your location...', textAlign: TextAlign.center, needsIcon: false, color: Colors.black38),
                          MaterialButton(
                            onPressed: () {
                              // fetch schoools again
                              PermissionHandler.askLocationPermission();
                            },
                            child: Icon(
                              Icons.refresh,
                              color: AppColors.primaryColor,
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: schoolsNearMe.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SchoolCard(
                              school: schoolsNearMe[index],
                              showDistance: true,
                            );
                          }))
              : selectedSchools.isEmpty
                  ? widget.schools.isEmpty
                      ? Container(
                          height: Get.size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImages.logo))),
                              ),
                              CustomText('We do not have schools matching "${levels.elementAt(levelSelectedIndex!)}" near your location! Try again later...',
                                  textAlign: TextAlign.center, needsIcon: false, color: Colors.black38),
                              MaterialButton(
                                onPressed: () {
                                  // fetch schoools again
                                  PermissionHandler.askLocationPermission();
                                },
                                child: Icon(
                                  Icons.refresh,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.schools.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SchoolCard(
                                  school: widget.schools[index],
                                  showDistance: true,
                                );
                              }),
                        )
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectedSchools.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SchoolCard(
                              school: selectedSchools[index],
                              showDistance: true,
                            );
                          }),
                    )
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

List<String> levels = [
  'All',
  'Pre-School',
  'Primary',
  'High School',
  'Tertiary',
];
