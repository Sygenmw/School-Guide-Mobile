import 'package:cloud_firestore/cloud_firestore.dart';

class EduBlogDetails {
  EduBlogDetails({
    required this.createdAt,
    required this.postAuthor,
    required this.enableComments,
    required this.postContent,
    required this.postCover,
    required this.postDescription,
    required this.publishPost,
    required this.postTitle,
  });

  final Timestamp createdAt;
  final String postAuthor;
  final bool enableComments;
  final String postContent;
  final String postCover;
  final String postDescription;
  final bool publishPost;
  final String postTitle;

  factory EduBlogDetails.fromDocument(DocumentSnapshot doc) => EduBlogDetails(
        createdAt: doc["createdAt"],
        enableComments: doc["enableComments"],
        postAuthor: doc["postAuthor"],
        postContent: doc["postContent"],
        postCover: doc["postCover"],
        postDescription: doc["postDescription"],
        postTitle: doc["postTitle"],
        publishPost: doc["publishPost"],
      );
}
