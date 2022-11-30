import 'dart:convert';

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
    required this.id,
    this.favourite = false,
  });

  final Timestamp createdAt;
  final String postAuthor;
  final bool enableComments;
  final String postContent;
  final String postCover;
  final String postDescription;
  final bool publishPost;
  final String postTitle;
  final String id;
  final bool favourite;

  factory EduBlogDetails.fromDocument(DocumentSnapshot doc) => EduBlogDetails(
        createdAt: doc["createdAt"],
        enableComments: doc["enableComments"],
        postAuthor: doc["postAuthor"],
        postContent: doc["postContent"],
        postCover: doc["postCover"],
        postDescription: doc["postDescription"],
        postTitle: doc["postTitle"],
        publishPost: doc["publishPost"],
        id: doc.id,
      );

// to do with encoding and decoding when creating a local favourite list
  factory EduBlogDetails.fromJson(Map<String, dynamic> json) => EduBlogDetails(
        createdAt: json["createdAt"],
        enableComments: json["enableComments"],
        postAuthor: json["postAuthor"],
        postContent: json["postContent"],
        postCover: json["postCover"],
        postDescription: json["postDescription"],
        postTitle: json["postTitle"],
        publishPost: json["publishPost"],
        id: json['id'],
        favourite: false,
      );

  static Map<String, dynamic> toMap(EduBlogDetails blog) => {
        "createdAt": blog.createdAt,
        "enableComments": blog.enableComments,
        "postAuthor": blog.postAuthor,
        "postContent": blog.postContent,
        "postCover": blog.postCover,
        "postDescription": blog.postDescription,
        "postTitle": blog.postTitle,
        "publishPost": blog.publishPost,
        "id": blog.id,
        "favourite": blog.favourite,
      };

  // encoding the Data Class
  static String encode(List<EduBlogDetails> blogDetails) => json.encode(
        blogDetails.map<Map<String, dynamic>>((blogDetail) => EduBlogDetails.toMap(blogDetail)).toList(),
      );

  static List<EduBlogDetails> decode(String blogDetails) => (json.decode(blogDetails) as List<dynamic>).map<EduBlogDetails>((blogDetail) => EduBlogDetails.fromJson(blogDetail)).toList();
}
