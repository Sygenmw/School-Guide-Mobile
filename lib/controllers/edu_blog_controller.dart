import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EduBlogController extends GetxController {
  var allBlogPosts = <EduBlogDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    allBlogPosts.bindStream(_getAllBlogs());
  }

  Stream<List<EduBlogDetails>> _getAllBlogs() {
    return FirebaseFirestore.instance.collection('eduBlog').snapshots().map((QuerySnapshot snapshot) => snapshot.docs
        .map(
          (DocumentSnapshot doc) => EduBlogDetails.fromDocument(doc),
        )
        .toList());
  }

  // save the blogDetail into sharedPreferences
  static SharedPreferences? prefs;
  // initialize
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  setBlogPrefs({required EduBlogDetails blog, required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var detail = EduBlogDetails.encode(allBlogPosts).toString();
    await prefs.setString(key, detail);
  }

  static String? getBlogPrefs() => prefs!.getString('blogItem');
}

// class BlogPreferences {
//   static SharedPreferences? prefs;

//   setBlog(List<String> blogs) async {
//     // final String encodeData = EduBlogDetails.encode(allBlogPosts);
//     await prefs!.setStringList('blogKey', blogs);
//   }

//   static List<String>? getBlogs() => prefs!.getStringList('blogKey');

//   // final List<EduBlogDetails> blogs = EduBlogDetails.decode(blogString!);

// }
