import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/scholarships/scholarship_details.dart';

class ScholarshipCard extends StatelessWidget {
  const ScholarshipCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.scholarshipLevels,
      required this.deadline,
      required this.countryOfScholarship,
      required this.commencementDates,
      required this.image})
      : super(key: key);
  final String title;
  final String image;
  final String subtitle;
  final String scholarshipLevels;
  final String deadline;
  final String countryOfScholarship;
  final String commencementDates;

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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const ScholarshipDetails();
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: FittedBox(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(image),
                        backgroundColor: AppColors.primaryColor,
                        radius: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subtitle,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                scholarshipLevels,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deadline : $deadline',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                'Study in : $countryOfScholarship',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                'Course starts : $commencementDates',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
