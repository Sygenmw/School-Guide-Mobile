import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/curriculum_controller.dart';
import 'package:school_guide/models/curriculum_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/curriculum_card.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/empty_list.dart';

class Curriculum extends StatefulWidget {
  const Curriculum({Key? key}) : super(key: key);

  @override
  State<Curriculum> createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  final CurriculumController curriculumController = Get.find();

  var curriculums = <CurriculumDetails>[];
  getCurriculums() {
    for (var curriculum in curriculumController.allCurriculums) {
      curriculums.add(curriculum);
    }
  }

  @override
  void initState() {
    getCurriculums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backIconAvailable: false,
        isHomeAppBar: true,
      ),
      body: CustomBody(text: 'Curriculums', children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(AppImages.curriculum),
                  ),
                )),
            Expanded(
              flex: 5,
              child: Text(
                'The Curriculum section covers information about the curriculums widely used in Malawi.'
                'This helps in making a sound decision on which school to enrol into.',
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        curriculums.isEmpty
            ? EmptyList(text: 'Sorry we have no curriculums at present! Please come back later.')
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: curriculums.length,
                itemBuilder: (BuildContext context, int index) {
                  return CurriculumCard(curriculum: curriculums[index]);
                },
              ),
      ]),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
