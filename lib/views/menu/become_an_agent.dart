import 'package:flutter/material.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class BecomeAnAgent extends StatelessWidget {
  const BecomeAnAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Become an agent',
        needsHeader: true,
        children: [
          
        ],
      ),
    );
  }
}
