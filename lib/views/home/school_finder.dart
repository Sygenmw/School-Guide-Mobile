import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/school_card.dart';

import '../widgets/custom_body.dart';

class SchoolFinder extends StatelessWidget {
  SchoolFinder({Key? key}) : super(key: key);
  final SchoolsNearController schoolController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backIconAvailable: true,
        isHomeAppBar: true,
      ),
      body: CustomBody(
        needsHeader: true,
        text: '',
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: schoolController.allSchools.length,
              itemBuilder: (BuildContext context, int index) {
                return SchoolCard(
                  school: schoolController.allSchools[index],
                  showDistance: true,
                );
              })
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
