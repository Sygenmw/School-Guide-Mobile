import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/agent_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentInformation extends StatelessWidget {
  const AgentInformation({Key? key, required this.agent}) : super(key: key);

  final AgentDetails agent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Agent/${agent.name}',
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(height: 250, width: Get.size.width, child: CachedImage(imageUrl: agent.logo)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      agent.description,
                      style: const TextStyle(
                        fontSize: 16,
                        wordSpacing: 2.8,
                      ),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Contact info',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      String subject = 'INQUIRY';
                      String body = 'Hello, ${agent.name}, I wanted ...';
                      String query = 'mailto:${agent.email}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
                      launchUrl(Uri.parse(query));
                      // launchUrl(Uri.parse(school.email), mode: LaunchMode.externalApplication);
                    },
                    child: CustomText(
                      agent.email,
                      icon: Icons.email,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('tel:${agent.phoneNumber}'), mode: LaunchMode.externalApplication);
                    },
                    child: CustomText(agent.phoneNumber, icon: Icons.phone_android),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      launchUrl(Uri.parse(agent.website), mode: LaunchMode.externalApplication);
                    },
                    child: CustomText(agent.website, icon: Icons.circle, color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
