import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDetails {
  ViewDetails({required this.allViews, required this.blogID});
  final String blogID;
  final List<View> allViews;

  factory ViewDetails.fromDocument(DocumentSnapshot? doc) => ViewDetails(
        blogID: doc!.id,
        allViews: List<View>.from(doc["allViews"].map((e) => View.fromMap(e))).toList(),
      );

  Map<String, dynamic> toDocument() => {
        "deviceID": allViews.map((e) => e),
      };
}

class View {
  final String deviceID;

  View({required this.deviceID});

  factory View.fromMap(Map<String, dynamic> doc) => View(
        deviceID: doc['deviceID'],
      );
}
