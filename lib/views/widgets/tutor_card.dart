import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_guide/models/tutor_details.dart';
import 'package:school_guide/style/app_styles.dart';

class TutorCard extends StatelessWidget {
  const TutorCard({super.key, required this.tutor});
  final TutorDetails tutor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grey,
        ),
        child: SizedBox(
          height: 95,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: tutor.tutorImage,
                    fit: BoxFit.cover,
                    height: 95,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${tutor.name} - ${tutor.curriculum}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              tutor.email,
                              style: const TextStyle(color: AppColors.black, fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              tutor.phone,
                              style: const TextStyle(color: AppColors.black, fontSize: 14),
                            ),
                          ),
                          Text(tutor.subjects.join(', ')),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
