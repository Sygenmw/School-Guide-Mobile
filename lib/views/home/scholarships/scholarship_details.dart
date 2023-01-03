import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/models/scholarship_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholarshipDetailsView extends StatelessWidget {
  const ScholarshipDetailsView({Key? key, required this.scholarship}) : super(key: key);
  final ScholarshipDetails scholarship;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Scholarships/Details',
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Column generated Picture
                      Text(
                        '${scholarship.destination} Student Scholarship',
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          scholarship.scholarshipName,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Second Column generated Picture
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Hero(
                          tag: scholarship.scholarshipName,
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(100),
                            child: CachedImage(
                              imageUrl: scholarship.scholarshipLogo,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Brief description',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.scholarshipDescription,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Host Institution',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.hostUniversity,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Level/Fields of study',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.level,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Number of Scholarships',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '${scholarship.numberOfScholarschips}',
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Target group',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.targetGroup,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Applications begin on',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              TimeConversion.convertTimeStamp(scholarship.startDate),
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Applications end on',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              TimeConversion.convertTimeStamp(scholarship.deadline),
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Material(
                    child: InkWell(
                      onTap: (() {
                        //
                        HapticFeedback.mediumImpact();
                        launchUrl(Uri.parse(scholarship.linkToTheScholarshipSite));
                      }),
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'More information',
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              ),
                              Icon(Icons.keyboard_arrow_right, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              elevation: 5,
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  String link =
                      "Access the best schools to enroll into and view latest scholarships using the School Guide App available on https://play.google.com/store/apps/details?id=com.school.guide.malawi&hl=en&gl=US&pli=1";

                  // share blog
                  HapticFeedback.heavyImpact();
                  String scholarshipDetail =
                      '\n*${scholarship.scholarshipName}*\n\n\n${scholarship.scholarshipDescription}\n\n*School*\n${scholarship.hostUniversity}\n\n${scholarship.level} Scholarship\n\n*Target group*\n${scholarship.targetGroup}\n\n*Deadline*\n${TimeConversion.convertTimeStamp(scholarship.deadline)}';
                  await Share.share(
                    '$scholarshipDetail\n\n$link',
                  );
                },
                child: Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.share,
                        color: AppColors.white,
                      ),
                    )),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar());
  }
}
