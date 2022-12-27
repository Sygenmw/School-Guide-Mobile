import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_guide/controllers/location_controller.dart';
import 'package:school_guide/controllers/school_views_controller.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/models/views_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';

class SchoolCard extends StatefulWidget {
  const SchoolCard({Key? key, required this.school, this.showDistance = false}) : super(key: key);
  final SchoolDetails school;
  final bool showDistance;

  @override
  State<SchoolCard> createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  double lat = 0;
  double long = 0;
  double distance = 0.0;
  // int count = 0;
  ViewDetails views = ViewDetails(views: 0, id: '');
  final SchoolViewsController controllers = Get.find();
  getSchoolViews() {
    controllers.allSchoolViews.forEach((schoolView) {
      if (schoolView.id == widget.school.id) {
        views = schoolView;
      }
    });
  }

  void initState() {
    getSchoolViews();
    Timer.periodic(const Duration(seconds: 5), (z) {
      getGeoPoint();
      distance = calculateDistance(
          source: LatLng(lat, long),
          //  substitute with school
          dest: LatLng(
            widget.school.location.lat,
            widget.school.location.lng,
          ));
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              views.views++;
            });

            var docRef = FirebaseFirestore.instance.collection('schoolViews').doc(widget.school.id);
            docRef.set({"views": views.views}).then((value) => () {
                  docRef.update({"views": FieldValue.increment(views.views)});
                });
            Get.to(() => SchoolInfo(
                  school: widget.school,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 12, right: 12, bottom: 0),
                    child: SizedBox(
                      child: Hero(
                        tag: widget.school.schoolName,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(widget.school.schoolLogo),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.school.schoolName,
                            style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              const ImageIcon(
                                AssetImage(
                                  AppImages.graduation,
                                ),
                                color: AppColors.white,
                                size: 14,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  widget.school.levelOfStudy,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const ImageIcon(
                                  AssetImage(
                                    AppImages.location,
                                  ),
                                  color: AppColors.white,
                                  size: 14,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Text(
                                        widget.school.address.length < 26 ? widget.school.address : widget.school.address.substring(0, 26),
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      widget.showDistance
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    AppImages.km,
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0, right: 10),
                                    child: Text(
                                      distance == 0.0 ? 'Calculating distance' : 'Approx. ${distance.truncateToDouble()} km from you',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
