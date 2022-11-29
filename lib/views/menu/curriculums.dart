import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

class Curriculums extends StatelessWidget {
  const Curriculums({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Curriculums',
        needsHeader: true,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Card(
                    margin: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.workspace_premium_outlined,
                        color: AppColors.primaryColor,
                        size: 35,
                      ),
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Text(
                  'These are some of the most featured curriculums available for tutoring and learning.',
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          TopBlackText(text: 'Curriculums'),
          Divider(),
          Wrap(
              children: curriculums
                  .map(
                    (e) => Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: TopBlackText(text: e),
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

List<String> curriculums = ["IGCSE", "MANEB", "AMERICAN CURRICULUM", "CAMBRIDGE", "0+ Levels"];
