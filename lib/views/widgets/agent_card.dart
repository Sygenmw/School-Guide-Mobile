import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/agent_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/agents/agent_information.dart';

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
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                agent.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  'Services: ${agent.servicesProvided.length < 40 ? agent.servicesProvided : agent.servicesProvided.substring(0, 40)}',
                                  style: const TextStyle(color: AppColors.black, fontSize: 14),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 6,
                            right: 8,
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
                            ))
                      ],
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

  List<Color> cardColors = [Colors.red, Colors.blue, Colors.greenAccent, Colors.lime, Colors.brown, Colors.green, Colors.pink, Colors.teal, Colors.black, Colors.deepPurple, Colors.purple];
  Color chooseRandomColor() {
    Random random = Random();
    var rand = random.nextInt(cardColors.length);

    return cardColors.elementAt(rand);
  }
}
