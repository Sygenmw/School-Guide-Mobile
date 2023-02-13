import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/video_model.dart';
import 'package:school_guide/models/views_model.dart';

class VideoViewsController extends GetxController {
  var allVideoViews = <ViewDetails>[].obs;
  var allVideos = <VideoDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    allVideoViews.bindStream(_getAllSchoolViews());
    allVideos.bindStream(_getAllVideos());
  }

  Stream<List<ViewDetails>> _getAllSchoolViews() {
    return FirebaseFirestore.instance.collection('videoViews').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => ViewDetails.fromDocument(doc)).toList());
  }

  Stream<List<VideoDetails>> _getAllVideos() {
    return FirebaseFirestore.instance.collection('videos').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => VideoDetails.fromDocument(doc)).toList());
  }

  ViewDetails currentVideoViews(String vidID) {
    try {
      return allVideoViews.where((views) => views.id == vidID).first;
    } catch (e) {
      return ViewDetails(views: 0, id: '');
    }
  }
}
