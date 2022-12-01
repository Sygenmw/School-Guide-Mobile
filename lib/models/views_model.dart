import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDetails {
  ViewDetails({
    required this.views,
    required this.id,
  });
  final int views;
  final String id;

  factory ViewDetails.fromDocument(DocumentSnapshot? doc) => ViewDetails(views: doc!["views"], id: doc.id);
}
