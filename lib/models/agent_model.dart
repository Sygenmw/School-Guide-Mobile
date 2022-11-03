import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AgentDetails extends GetxController {
  AgentDetails({
    required this.name,
    required this.logo,
    required this.description,
    required this.email,
    required this.servicesProvided,
    required this.phoneNumber,
    required this.website,
  });
  final String name;
  final String logo;
  final String description;
  final String email;
  final String servicesProvided;
  final String phoneNumber;
  final String website;

  factory AgentDetails.fromDocument(DocumentSnapshot doc) => AgentDetails(
        logo: doc['AgentLogo'],
        description: doc['agentDescription'],
        name: doc['agentName'],
        servicesProvided: doc['servicesProvided'],
        phoneNumber: doc['agentPhoneNumber'],
        website: doc['agentWebsite'],
        email: doc['agentEmail'],
      );
}
