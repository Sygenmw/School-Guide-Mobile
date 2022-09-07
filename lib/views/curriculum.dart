import 'package:flutter/material.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class Curriculum extends StatelessWidget {
  const Curriculum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        backIconAvailable: true,
        isHomeAppBar: true,
      ),
      body: CustomBody(
        text: 'Curriculum',
        children: [],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
