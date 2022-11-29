import 'package:cloud_firestore/cloud_firestore.dart';

class BannerDetails {
  BannerDetails({
    required this.bannerDescription,
    required this.bannerLink,
    required this.schoolID,
    required this.bannerTitle,
    required this.createdAt,
    required this.linkType,
    required this.bannerImage,
    required this.deadline,
  });

  final String bannerDescription;
  final String bannerImage;
  final String bannerLink;
  final String bannerTitle;
  final Timestamp createdAt;
  final Timestamp deadline;
  final String linkType;
  final String schoolID;

  factory BannerDetails.fromDocument(DocumentSnapshot? doc) => BannerDetails(
        bannerDescription: doc!["bannerDescription"] ?? '',
        bannerImage: doc["bannerImage"] ?? '',
        bannerLink: doc["bannerLink"] ?? '',
        schoolID: doc["schoolID"] ?? '',
        bannerTitle: doc["bannerTitle"] ?? '',
        createdAt: doc["createdAt"] ?? Timestamp.now(),
        linkType: doc["linkType"] ?? '',
        deadline: doc["deadline"] ?? Timestamp.now(),
      );
}
