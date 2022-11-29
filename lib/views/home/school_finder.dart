import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
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
          schoolController.allSchools.isEmpty
              ? Container(
                  height: Get.size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImages.logo))),
                      ),
                      CustomText('We do not have schools at present! Try again sometime...', textAlign: TextAlign.center, needsIcon: false, color: Colors.black38)
                    ],
                  ),
                )
              : ListView.builder(
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
