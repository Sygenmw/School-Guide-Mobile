import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarshipDetails {
  ScholarshipDetails({
    required this.createdAt,
    required this.destination,
    required this.hostUniversity,
    required this.level,
    required this.linkToTheScholarshipSite,
    required this.numberOfScholarschips,
    required this.scholarshipDescription,
    required this.scholarshipLogo,
    required this.scholarshipName,
    required this.targetGroup,
    required this.deadline,
    required this.startDate,
  });

  final Timestamp createdAt;
  final Timestamp deadline;
  final Timestamp startDate;
  final String destination;
  final String hostUniversity;
  final String level;
  final String linkToTheScholarshipSite;
  final String numberOfScholarschips;
  final String scholarshipDescription;
  final String scholarshipLogo;
  final String scholarshipName;
  final String targetGroup;

  factory ScholarshipDetails.fromDocument(DocumentSnapshot doc) => ScholarshipDetails(
        createdAt: doc["createdAt"],
        destination: doc["destination"],
        hostUniversity: doc["hostUniversity"],
        deadline: doc['deadline'],
        startDate: doc['startDate'],
        level: doc["level"],
        linkToTheScholarshipSite: doc["linkToTheScholarshipSite"],
        numberOfScholarschips: doc["numberOfScholarships"],
        scholarshipDescription: doc["scholarshipDescription"],
        scholarshipLogo: doc["scholarshipLogo"],
        scholarshipName: doc["scholarshipName"],
        targetGroup: doc["targetGroup"],
      );
}
