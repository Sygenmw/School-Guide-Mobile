import 'package:flutter/material.dart';
import 'package:school_guide/models/curriculum_model.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class CurriculumInfo extends StatelessWidget {
  const CurriculumInfo({Key? key, required this.curriculum}) : super(key: key);

  final CurriculumDetails curriculum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Curriculum/${curriculum.title}',
          children: [
            Container(height: 130, child: CachedImage(imageUrl: curriculum.logo, fit: BoxFit.fill)),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      curriculum.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      curriculum.description,
                      style: const TextStyle(
                        fontSize: 16,
                        wordSpacing: 2.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
