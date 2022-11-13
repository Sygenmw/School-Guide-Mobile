import 'package:flutter/material.dart';
import 'package:school_guide/models/scholarship_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

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
                          fontSize: 30,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          scholarship.scholarshipName,
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.scholarshipDescription,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Host Institution(s):',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.hostUniversity,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Level/Fields of study:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.level,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Number of Scholarships:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'A class of ${scholarship.numberOfScholarschips} Scholars is selected each year',
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Target group:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              scholarship.targetGroup,
              style: const TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: AppColors.primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'MORE INFORMATION',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Icon(Icons.keyboard_arrow_right, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
