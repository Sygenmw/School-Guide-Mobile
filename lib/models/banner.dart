import 'package:cloud_firestore/cloud_firestore.dart';

class BannerDetails {
  BannerDetails({
    required this.bannerDescription,
    required this.bannerLink,
    required this.schoolID,
    required this.bannerTitle,
    required this.createdAt,
    required this.linkType,
    required this.updatedAt,
    required this.bannerImage,
    required this.dateLine,
  });

  final String bannerDescription;
  final String bannerImage;
  final String bannerLink;
  final String bannerTitle;
  final Timestamp createdAt;
  final String linkType;
  final String schoolID;
  final Timestamp updatedAt;
  final Timestamp dateLine;

  factory BannerDetails.fromDocument(DocumentSnapshot doc) => BannerDetails(
        bannerDescription: doc["bannerDescription"],
        bannerImage: doc["bannerImage"],
        bannerLink: doc["bannerLink"],
        schoolID: doc["schoolID"],
        bannerTitle: doc["bannerTitle"],
        createdAt: doc["createdAt"],
        linkType: doc["linkType"],
        updatedAt: doc["updatedAt"],
        dateLine: doc["dateLine"],
      );
}
