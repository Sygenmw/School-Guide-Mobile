import 'package:cloud_firestore/cloud_firestore.dart';

class Banner {
  Banner({
    required this.bannerDescription,
    required this.bannerLink,
    required this.bannerLocation,
    required this.bannerSchool,
    required this.bannerTitle,
    required this.createdAt,
    required this.linksDropDown,
    required this.school,
    required this.schoolLogo,
    required this.updatedAt,
  });

  final String bannerDescription;
  final String bannerLink;
  final List<String> bannerLocation;
  final String bannerSchool;
  final String bannerTitle;
  final String createdAt;
  final String linksDropDown;
  final String school;
  final String schoolLogo;
  final String updatedAt;

  factory Banner.fromDocument(DocumentSnapshot doc) => Banner(
        bannerDescription: doc["bannerDescription"],
        bannerLink: doc["bannerLink"],
        bannerLocation: List<String>.from(doc["bannerLocation"].map((location) => location)),
        bannerSchool: doc["bannerSchool"],
        bannerTitle: doc["bannerTitle"],
        createdAt: doc["createdAt"],
        linksDropDown: doc["linksDropDown"],
        school: doc["school"],
        schoolLogo: doc["schoolLogo"],
        updatedAt: doc["updatedAt"],
      );
}
