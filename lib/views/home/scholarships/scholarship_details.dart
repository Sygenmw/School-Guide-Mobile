import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class ScholarshipDetails extends StatelessWidget {
  const ScholarshipDetails({Key? key}) : super(key: key);

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
                    children: const [
                      // First Column generated Picture
                      Text(
                        'International Student Scholarship',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Rhodes Scholarship at Oxford University',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                      Image.network(
                        'https://th.bing.com/th/id/R.486f1764f961de3df42c5ef175617f9f?rik=3G1Z2eo7vlRBTA&riu=http%3a%2f%2fwww.ranklogos.com%2fwp-content%2fuploads%2f2012%2f05%2foxford.png&ehk=YX8yI5GIvlMlfwVa%2fTj4pXdVyFl6N37BrqCvarDmOco%3d&risl=&pid=ImgRaw&r=0',
                        height: 110,
                        width: 110,
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
            const Text(
              'The Rhodes Scholarships are postgraduate awards supporting exceptional all-round students at the University of Oxford. Established in the will of Cecil Rhodes in 1902, the Rhodes is the oldest and perhaps the most prestigious international scholarship program in the world. ',
              style: TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Host Institution(s):',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Oxford University in UK',
              style: TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Level/Fields of study:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Subject to limited restrictions, Rhodes Scholars may study any full-time postgraduate degree at the University of Oxford.',
              style: TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Number of Scholarships:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'A class of 95 Scholars is selected each year',
              style: TextStyle(fontSize: 16, wordSpacing: 2.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Target group:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Lesotho, Malawi, Namibia and eSwatini), Syria, Jordan, Lebanon, Palestine, United Arab Emirates, United States (50 states of the US, the District of Columbia, and the U.S. territories of American Samoa, Guam, Northern Mariana Islands, Puerto Rico and the U.S. Virgin Islands), West Africa (Benin, Burkina Faso, Cape Verde, Gambia, Ghana, Guinea, Guinea-Bissau, Ivory Coast, Liberia, Mali, Mauritania, Niger, Nigeria, the island of Saint Helena, Senegal, Sierra Leone, São Tomé and Principe and Togo), Zambia, and Zimbabwe',
              style: TextStyle(fontSize: 16, wordSpacing: 2.2),
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
