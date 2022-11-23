import 'package:flutter/material.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class AdvertiseSchool extends StatelessWidget {
  const AdvertiseSchool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Advertise school or event',
        needsHeader: true,
        children: [],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
