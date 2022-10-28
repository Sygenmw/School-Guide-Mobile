import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/school_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

import '../widgets/bottom_navbar.dart';

class SchoolDirectory extends StatefulWidget {
  const SchoolDirectory({Key? key}) : super(key: key);

  @override
  State<SchoolDirectory> createState() => _SchoolDirectoryState();
}

class _SchoolDirectoryState extends State<SchoolDirectory> {
  int? destinationSelectedIndex;

  int? levelSelectedIndex;
  int? curriculumSelectedIndex;

  final SchoolsNearController schoolController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
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
                          levelSelectedIndex = null;
                          destinationSelectedIndex = null;
                          curriculumSelectedIndex = null;
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
                ? const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: TopBlackText(text: 'CURRICULUM'),
                  )
                : Container(),
            destinationSelectedIndex == 0 && levelSelectedIndex == 0
                ? SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: curriculums.length,
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
                                  curriculumSelectedIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: curriculumSelectedIndex == index ? AppColors.primaryColor : AppColors.white,
                                  border: Border.all(color: curriculumSelectedIndex != index ? AppColors.primaryColor : Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Center(
                                    child: Text(
                                      curriculums[index],
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: curriculumSelectedIndex == index ? AppColors.white : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:schoolController.allSchools.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SchoolCard(
                            school: schoolController.allSchools[index],
                          );
                        })
            )
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }

 
  List<String> destinations = [
    'Local',
    'International',
  ];
  List<String> levels = [
    'High School',
    'Bachelor\'s',
    'Master\'s',
    'Doctrorate',
  ];
  List<String> curriculums = [
    'MSCE',
    'IGCSE',
    'ALL',
  ];
}
