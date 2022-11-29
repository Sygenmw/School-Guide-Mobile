import 'package:cloud_firestore/cloud_firestore.dart';

class LikeDetails {
  LikeDetails({required this.allLikes, required this.blogID});
  final String blogID;
  final List<_Like> allLikes;

  factory LikeDetails.fromDocument(DocumentSnapshot? doc) => LikeDetails(
        blogID: doc!.id,
        allLikes: List<_Like>.from(doc["allLikes"].map((e) => _Like.fromMap(e))).toList() ?? [],
      );

  Map<String, dynamic> toDocument() => {
        "allLikes": allLikes.map((e) => e),
      };
}

class _Like {
  final String userID;

  _Like({required this.userID});

  factory _Like.fromMap(Map<String, dynamic> doc) => _Like(
        userID: doc['userID'],
      );
}
