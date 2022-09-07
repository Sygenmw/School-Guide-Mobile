import 'package:cloud_firestore/cloud_firestore.dart';

class Scholarship {
  Scholarship({
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
  });

  final Timestamp createdAt;
  final String destination;
  final String hostUniversity;
  final String level;
  final String linkToTheScholarshipSite;
  final int numberOfScholarschips;
  final String scholarshipDescription;
  final String scholarshipLogo;
  final String scholarshipName;
  final String targetGroup;

  factory Scholarship.fromDocument(DocumentSnapshot doc) => Scholarship(
        createdAt: doc["createdAt"],
        destination: doc["destination"],
        hostUniversity: doc["hostUniversity"],
        level: doc["level"],
        linkToTheScholarshipSite: doc["linkToTheScholarshipSite"],
        numberOfScholarschips: doc["numberOfScholarschips"],
        scholarshipDescription: doc["scholarshipDescription"],
        scholarshipLogo: doc["scholarshipLogo"],
        scholarshipName: doc["scholarshipName"],
        targetGroup: doc["targetGroup"],
      );
}
