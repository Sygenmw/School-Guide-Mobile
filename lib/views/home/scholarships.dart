import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/scholarship_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

class Scholarships extends StatefulWidget {
  const Scholarships({Key? key}) : super(key: key);

  @override
  State<Scholarships> createState() => _ScholarshipsState();
}

class _ScholarshipsState extends State<Scholarships> {
  int? destinationSelectedIndex;
  int? levelSelectedIndex;

  @override
  Widget build(BuildContext context) {
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
              child: allScholarships.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    )
                  : Column(
                      children: allScholarships.map((scholarshipCard) => scholarshipCard).toList(),
                    ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}

List<ScholarshipCard> allScholarships = [
  const ScholarshipCard(
    title: 'Rhodes Scholarship at Oxford University',
    subtitle: 'Rhodes Scholarship Fund',
    scholarshipLevels: 'Masters/PhD',
    deadline: 'varies July - Oct(annual)',
    countryOfScholarship: 'UK',
    commencementDates: 'October 2022',
    image: 'https://www.clipartkey.com/mpngs/m/31-311346_oxford-university-logo.png',
  ),
  const ScholarshipCard(
    title: 'HESLGB Scholarships',
    subtitle: 'Higher Education Loans and Grants Board',
    scholarshipLevels: 'Bachelors, Masters/PhD',
    deadline: 'Dec 2022',
    countryOfScholarship: 'Malawi',
    commencementDates: 'Jan 2023',
    image:
        'https://th.bing.com/th/id/R.bff78c59cf81cf3b58ae54259ed654a8?rik=g7jbxD7U2oJO%2bA&riu=http%3a%2f%2fwww.heslgb.mw%2fImages%2flogo.png&ehk=e5RQ5CxM%2fNy1fsgk%2fVbQiA3US2kNLM1tZr3g2Gq6tNU%3d&risl=&pid=ImgRaw&r=0',
  ),
];

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
