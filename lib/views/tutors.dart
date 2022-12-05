import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/tutor_controller.dart';
import 'package:school_guide/models/tutor_details.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/back_exit.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/empty_list.dart';
import 'package:school_guide/views/widgets/tutor_card.dart';

class Tutor extends StatefulWidget {
  const Tutor({Key? key}) : super(key: key);

  @override
  State<Tutor> createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  final TutorController tutorController = Get.find();

  var tutors = <TutorDetails>[];
  getTutors() {
    for (var tutor in tutorController.allTutors) {
      if (tutor.showInApp) {
        tutors.add(tutor);
      }
    }
  }

  @override
  void initState() {
    getTutors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Exitable(
      child: Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: false,
          isHomeAppBar: true,
        ),
        body: tutors.isEmpty
            ? EmptyList(text: 'Sorry we have no tutors at present! Please come back later.')
            : CustomBody(text: 'Tutors', children: [
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
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Tutors help students learn and understand curriculum based concepts and help in studying, assigenments and many more.',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: tutors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TutorCard(tutor: tutors[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return index == 2 ? Divider() : Container();
                  },
                ),
              ]),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
      ),
    );
  }
}
