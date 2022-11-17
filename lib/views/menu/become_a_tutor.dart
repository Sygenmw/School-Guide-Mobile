import 'package:flutter/material.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class BecomeATutor extends StatelessWidget {
  const BecomeATutor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Become a tutor',
        needsHeader: true,
        children: [],
      ),
    );
  }
}
