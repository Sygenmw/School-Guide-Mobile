import 'package:cloud_firestore/cloud_firestore.dart';

class LikeDetails {
  LikeDetails({required this.allLikes, required this.id});
  final String id;
  final List<Like> allLikes;

  factory LikeDetails.fromDocument(DocumentSnapshot? doc) => LikeDetails(
        id: doc!.id,
        allLikes: List<Like>.from(doc["likes"].map((e) => Like.fromMap(e))).toList(),
      );
  Map<String, dynamic> toDocument() => {
        "likes": allLikes.map((e) => e.toMap()).toList(),
      };
}

class Like {
  final String deviceID;

  Like({required this.deviceID});

  factory Like.fromMap(Map<String, dynamic> doc) => Like(
        deviceID: doc['deviceID'],
      );

  Map<String, dynamic> toMap() => {deviceID: "deviceID"};
}
