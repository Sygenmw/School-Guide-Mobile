import 'package:flutter/material.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';

class SchoolCard extends StatelessWidget {
  const SchoolCard({Key? key, required this.school, this.showDistance = false}) : super(key: key);
  final SchoolDetails school;
  final bool showDistance;

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
                  return SchoolInfo(
                    school: school,
                  );
                },
              ),
            );
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
                        tag: school.schoolName,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(school.schoolLogo),
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
                            school.schoolName,
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
                                  school.levelOfStudy,
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
                                        school.address.length < 26 ? school.address : school.address.substring(0, 26),
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
                      showDistance
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Icon(
                                    Icons.map,
                                    size: 12,
                                    color: AppColors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0, right: 10),
                                    child: Text(
                                      '12 km from you',
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
