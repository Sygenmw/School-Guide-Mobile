import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/school_card.dart';

import '../widgets/custom_body.dart';

class SchoolFinder extends StatelessWidget {
  const SchoolFinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backIconAvailable: true,
        isHomeAppBar: true,
      ),
      body: CustomBody(
        needsHeader: false,
        children: [
          Column(
            children: _allSchools,
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

List<Widget> _allSchools = [
  const SchoolCard(
    schoolImage: AppImages.bedirLogo,
    name: 'Bedir International Primary',
    schoolLevel: 'Primary',
    location: 'Lilongwe',
    distance: 22.2,
    showDistance: true,
  ),
];
