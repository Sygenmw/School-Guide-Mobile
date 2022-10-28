import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_guide/controllers/scholarship_controller.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/scholarship_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:get/get.dart';

class Scholarships extends StatefulWidget {
  const Scholarships({Key? key}) : super(key: key);

  @override
  State<Scholarships> createState() => _ScholarshipsState();
}

class _ScholarshipsState extends State<Scholarships> {
  int? destinationSelectedIndex;
  int? levelSelectedIndex;
  final ScholarshipController scholarshipController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(scholarshipController.allScholarships.length);
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Scholarships',
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
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: scholarshipController.allScholarships.isEmpty
                    ? Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              CircleAvatar(
                                backgroundImage: AssetImage(AppImages.bedirLogo),
                                radius: 40,
                              ),
                              Text(
                                'No Scholarships Available yet.\nCome sometime',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: scholarshipController.allScholarships.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ScholarshipCard(
                            scholarship: scholarshipController.allScholarships[index],
                          );
                        })),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}

List<String> destinations = [
  'Local',
  'International',
];
List<String> levels = [
  'Secondary',
  'High School',
  'Bachelor\'s',
  'Master\'s',
  'Doctrorate',
];
