
import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';

class SchoolCard extends StatelessWidget {
  const SchoolCard({Key? key, required this.schoolImage, required this.name, required this.schoolLevel, required this.location, this.distance = 0.0, this.showDistance = false}) : super(key: key);
  final String schoolImage;
  final String name;
  final String schoolLevel;
  final String location;
  final double distance;
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
                  return const SchoolInfo();
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
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      backgroundImage: AssetImage(schoolImage),
                      radius: 35,
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
                            name,
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
                                  schoolLevel,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const ImageIcon(
                                AssetImage(
                                  AppImages.location,
                                ),
                                color: AppColors.white,
                                size: 14,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  location,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      showDistance
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.map,
                                  size: 12,
                                  color: AppColors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0, right: 10),
                                  child: Text(
                                    '$distance km',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
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