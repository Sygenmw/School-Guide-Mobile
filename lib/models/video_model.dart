import 'package:cloud_firestore/cloud_firestore.dart';

class VideoDetails {
  VideoDetails({
    required this.thumbNail,
    required this.createdAt,
    required this.description,
    required this.link,
    required this.title,
  });

  final String thumbNail;
  final String link;
  final Timestamp createdAt;
  final String title;
  final String description;

  factory VideoDetails.fromDocument(DocumentSnapshot doc) => VideoDetails(
        createdAt: doc["createdAt"],
        description: doc['description'],
        link: doc['link'],
        thumbNail: doc['Thumbnail'],
        title: doc['title'],
      );
}
