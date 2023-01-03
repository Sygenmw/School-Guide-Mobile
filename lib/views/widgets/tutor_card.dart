import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_guide/models/tutor_details.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';

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
                  child: CachedImage(
                    imageUrl: tutor.tutorImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 23,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Text(
                              '${tutor.name} - ${tutor.curriculum}',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 15),
                            ),
                          ],
                        ),
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
                          '${tutor.phone} - ${tutor.location}',
                          style: const TextStyle(color: AppColors.black, fontSize: 14),
                        ),
                      ),
                      Text(tutor.subjects.join(', ')),
                      const Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
