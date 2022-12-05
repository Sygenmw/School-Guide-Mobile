import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/agent_controller.dart';
import 'package:school_guide/models/agent_model.dart';
import 'package:school_guide/views/widgets/agent_card.dart';
import 'package:school_guide/views/widgets/back_exit.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/empty_list.dart';

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
    return Exitable(
      child: Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: false,
          isHomeAppBar: true,
        ),
        body: agents.isEmpty
            ? EmptyList(
                text: 'We do not have any agents now. Try again later.',
              )
            : CustomBody(
                text: 'Agents',
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: agents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AgentCard(agent: agents[index]);
                    },
                  ),
                ],
              ),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}

// ignore: must_be_immutable
