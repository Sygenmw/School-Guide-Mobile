import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/school_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

import '../widgets/bottom_navbar.dart';

class SchoolDirectory extends StatefulWidget {
  const SchoolDirectory({Key? key}) : super(key: key);

  @override
  State<SchoolDirectory> createState() => _SchoolDirectoryState();
}

class _SchoolDirectoryState extends State<SchoolDirectory> {
  final SchoolsNearController schoolController = Get.find();
  int? destinationSelectedIndex = 0;

  int? levelSelectedIndex = 0;
  int? curriculumSelectedIndex = 0;

  List selectedSchools = [];

  getCurrentSchools() {}
  void getSchools({required String destination, required String level}) {
    selectedSchools.clear();
    schoolController.allSchools.forEach((school) {
      if (destination.toLowerCase() == 'all' && school.levelOfStudy.toLowerCase() == level.toLowerCase()) {
        setState(() {
          selectedSchools.add(school);
        });
      } else if (level.toLowerCase() == 'all' && school.destination.toLowerCase() == destination.toLowerCase()) {
        setState(() {
          selectedSchools.add(school);
        });
      } else if (school.destination.toLowerCase() == destination.toLowerCase() && school.levelOfStudy.toLowerCase() == level.toLowerCase()) {
        setState(() {
          selectedSchools.add(school);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: schoolController.allSchools.isEmpty
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
                    CustomText('We do not have schools at present! Try again later.', textAlign: TextAlign.center, needsIcon: false, color: Colors.black38)
                  ],
                ),
              )
            : CustomBody(
                text: 'School directory',
                children: [
                  const TopBlackText(text: 'DESTINATION'),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 38,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: destinations.length,
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
                                          destinationSelectedIndex = index;
                                        });
                                        getSchools(destination: destinations.elementAt(destinationSelectedIndex!), level: levels.elementAt(levelSelectedIndex!));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: destinationSelectedIndex == index ? AppColors.primaryColor : AppColors.white,
                                          border: Border.all(color: destinationSelectedIndex != index ? AppColors.primaryColor : Colors.transparent, width: 2),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: Center(
                                            child: Text(
                                              destinations[index],
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: destinationSelectedIndex == index ? AppColors.white : AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            splashRadius: 20,
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                levelSelectedIndex = 0;
                                destinationSelectedIndex = 0;
                                curriculumSelectedIndex = 0;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: TopBlackText(text: 'LEVEL OF STUDY'),
                  ),
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
                                getSchools(destination: destinations.elementAt(destinationSelectedIndex!), level: levels.elementAt(levelSelectedIndex!));
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
                  destinationSelectedIndex == 0 && levelSelectedIndex == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: schoolController.allSchools.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SchoolCard(
                                  school: schoolController.allSchools[index],
                                );
                              }))
                      : selectedSchools.isEmpty
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
                                  CustomText('No items match your filter!', textAlign: TextAlign.center, needsIcon: false, color: Colors.black38)
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: selectedSchools.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return SchoolCard(
                                      school: selectedSchools[index],
                                    );
                                  }))
                ],
              ),
        bottomNavigationBar: CustomBottomNavBar());
  }

  List<String> destinations = [
    'All',
    'Local',
    'International',
  ];
  List<String> levels = [
    'All',
    'Pre-School',
    'Primary',
    'High School',
    'Tertiary',
  ];
  List<String> curriculums = [
    'ALL',
    'MANEB',
    'IGCSE',
  ];
}
