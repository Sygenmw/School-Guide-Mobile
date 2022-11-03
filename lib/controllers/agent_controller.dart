import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/agent_model.dart';

class AgentController extends GetxController {
  var allAgents = <AgentDetails>[].obs;

  @override
  void onInit() {
    allAgents.bindStream(_getAllAgents());
    super.onInit();
  }

  Stream<List<AgentDetails>> _getAllAgents() {
    return FirebaseFirestore.instance.collection('agents').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => AgentDetails.fromDocument(doc)).toList());
  }
}
