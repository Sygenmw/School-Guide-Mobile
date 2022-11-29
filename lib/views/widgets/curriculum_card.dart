import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/curriculum_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/menu/curriculum/curriculum_info.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';

class CurriculumCard extends StatelessWidget {
  final CurriculumDetails curriculum;

  const CurriculumCard({super.key, required this.curriculum});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8),
      child: Container(
        height: 95,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grey,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              // Curriculum Details
              Get.to(() => CurriculumInfo(curriculum: curriculum));
            },
            child: CachedImage(
              imageUrl: curriculum.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
