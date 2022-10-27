import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/edu_blog.dart';

class EduBlogController extends GetxController {
  var allBlogPosts = <EduBlogDetails>[].obs;

  @override
  void onInit() {
    allBlogPosts.bindStream(_getAllBlogs());
    super.onInit;
  }

  Stream<List<EduBlogDetails>> _getAllBlogs() {
    return FirebaseFirestore.instance.collection('eduBlog').snapshots().map((QuerySnapshot snapshot) => snapshot.docs
        .map(
          (DocumentSnapshot doc) => EduBlogDetails.fromDocument(doc),
        )
        .toList());
  }
}
