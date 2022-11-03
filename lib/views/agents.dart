import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/agent_controller.dart';
import 'package:school_guide/models/agent_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:url_launcher/url_launcher.dart';

class Agents extends StatefulWidget {
  const Agents({Key? key}) : super(key: key);

  @override
  State<Agents> createState() => _AgentsState();
}

class _AgentsState extends State<Agents> {
  final AgentController agentController = Get.find();

  var agents = <AgentDetails>[];

  getAgents() {
    for (var agent in agentController.allAgents) {
      agents.add(agent);
      print(agents.length);
    }
  }

  @override
  void initState() {
    getAgents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backIconAvailable: false,
        isHomeAppBar: true,
      ),
      body: CustomBody(
        text: agents.isEmpty ? 'HEMPTY' : 'Agents',
        children: [
          SizedBox(
            height: Get.size.height,
            child: ListView.builder(
              itemCount: agents.length,
              itemBuilder: (BuildContext context, int index) {
                return AgentCard(agent: agents[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

class AgentCard extends StatelessWidget {
  AgentCard({Key? key, required this.agent}) : super(key: key);
  final AgentDetails agent;

  @override
  Widget build(BuildContext context) {
    var rColor = chooseRandomColor();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 210, 214, 242),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              // Video Details
              Get.to(() => AgentInformation(agent: agent));
            },
            child: SizedBox(
              height: 95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: agent.logo,
                        fit: BoxFit.cover,
                        height: 95,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              agent.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              agent.description.length < 100 ? agent.description : agent.description.substring(0, 80),
                              style: const TextStyle(color: AppColors.black, fontSize: 14),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0, right: 12),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Card(
                                  color: rColor,
                                  margin: const EdgeInsets.all(0),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'More info',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Color> cardColors = [Colors.red, Colors.blue, Colors.green, Colors.pink, Colors.teal, Colors.black, Colors.deepPurple, Colors.purple];
  Color chooseRandomColor() {
    Random random = Random();
    var rand = random.nextInt(cardColors.length);

    return cardColors.elementAt(rand);
  }
}

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
                    child: CustomText(agent.website, icon: Icons.circle),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
