import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/views_model.dart';

class VideoViewsController extends GetxController {
  var allVideoViews = <ViewDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    allVideoViews.bindStream(_getAllSchoolViews());
  }

  Stream<List<ViewDetails>> _getAllSchoolViews() {
    return FirebaseFirestore.instance.collection('videoViews').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => ViewDetails.fromDocument(doc)).toList());
  }
}
