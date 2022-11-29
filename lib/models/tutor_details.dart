import 'package:cloud_firestore/cloud_firestore.dart';

class TutorDetails {
  final String tutorImage;
  final String name;
  final String email;
  final String phone;
  final String curriculum;
  final bool showInApp;
  final List<String> subjects;

  TutorDetails({
    required this.tutorImage,
    required this.name,
    required this.email,
    required this.phone,
    required this.curriculum,
    required this.subjects,
    required this.showInApp,
  });

  factory TutorDetails.fromDocument(DocumentSnapshot? doc) => TutorDetails(
        curriculum: doc!['curriculum'],
        email: doc['email'],
        name: doc['name'],
        phone: doc['phone'],
        showInApp: doc['showInApp'],
        subjects: List<String>.from(doc['subjects']),
        tutorImage: doc['tutorImage'],
      );
}
