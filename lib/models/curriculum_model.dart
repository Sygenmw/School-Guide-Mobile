import 'package:cloud_firestore/cloud_firestore.dart';

class CurriculumDetails {
  final Timestamp createdAt;
  final String link;
  final String description;
  final String logo;
  final String title;

  CurriculumDetails({
    required this.createdAt,
    required this.link,
    required this.description,
    required this.logo,
    required this.title,
  });

  factory CurriculumDetails.fromDocument(DocumentSnapshot? doc) =>
      CurriculumDetails(createdAt: doc!['createdAt'], link: doc['link'], description: doc['description'], logo: doc['logo'], title: doc['title']);
}
