import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDetails {
  ViewDetails({
    required this.views,
    required this.id,
  });
    int views;
  final String id;

  factory ViewDetails.fromDocument(DocumentSnapshot? doc) => ViewDetails(views: doc!["views"], id: doc.id);
}
