import 'package:cloud_firestore/cloud_firestore.dart';

class EduBlog {
  EduBlog({
    required this.createdAt,
    required this.postAuthor,
    required this.postCommentsEnable,
    required this.postContent,
    required this.postCover,
    required this.postDescription,
    required this.postPublish,
    required this.postTitle,
  });

  final String createdAt;
  final String postAuthor;
  final bool postCommentsEnable;
  final String postContent;
  final String postCover;
  final String postDescription;
  final bool postPublish;
  final String postTitle;

  factory EduBlog.fromDocument(DocumentSnapshot doc) => EduBlog(
        createdAt: doc["createdAt"],
        postAuthor: doc["postAuthor"],
        postCommentsEnable: doc["postCommentsEnable"],
        postContent: doc["postContent"],
        postCover: doc["postCover"],
        postDescription: doc["postDescription"],
        postPublish: doc["postPublish"],
        postTitle: doc["postTitle"],
      );
}
