import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
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

import '../widgets/custom_body.dart';

class SchoolFinder extends StatefulWidget {
  SchoolFinder({Key? key, required this.schools}) : super(key: key);
  final List<SchoolDetails> schools;

  @override
  State<SchoolFinder> createState() => _SchoolFinderState();
}

class _SchoolFinderState extends State<SchoolFinder> {
  final SchoolsNearController schoolController = Get.find();
  double lat = 0;
  double long = 0;
  double distance = 0.0;
  List<SchoolDetails> schoolsNearMe = [];
  Timer time = Timer(Duration(seconds: 0), () {});
  void initState() {
    PermissionHandler.askLocationPermission();

    Timer.periodic(const Duration(seconds: 4), (timer) {
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
        text: '',
        children: [
          schoolsNearMe.isEmpty
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
                          CustomText('We do not have schools at present! Try again later...', textAlign: TextAlign.center, needsIcon: false, color: Colors.black38),
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
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.schools.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SchoolCard(
                          school: widget.schools[index],
                          showDistance: true,
                        );
                      })
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: schoolsNearMe.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SchoolCard(
                      school: schoolsNearMe[index],
                      showDistance: true,
                    );
                  })
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
