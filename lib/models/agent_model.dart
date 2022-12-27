import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AgentDetails extends GetxController {
  AgentDetails({
    required this.name,
    required this.logo,
    required this.location,
    required this.description,
    required this.email,
    required this.servicesProvided,
    required this.phoneNumber,
    required this.website,
    required this.status,
  });
  final String name;
  final String logo;
  final String description;
  final String location;
  final String email;
  final String servicesProvided;
  final String phoneNumber;
  final String website;
  final String status;

  factory AgentDetails.fromDocument(DocumentSnapshot doc) => AgentDetails(
        logo: doc['AgentLogo'],
        description: doc['agentDescription'],
        location: doc['location'],
        name: doc['agentName'],
        status: doc['status'],
        servicesProvided: doc['servicesProvided'],
        phoneNumber: doc['agentPhoneNumber'],
        website: doc['agentWebsite'],
        email: doc['agentEmail'],
      );
}
