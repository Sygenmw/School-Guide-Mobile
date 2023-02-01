import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/video_model.dart';

class VideoController extends GetxController {
  var allVideos = <VideoDetails>[].obs;

  @override
  void onInit() {
    allVideos.bindStream(_getAllVideos());
    super.onInit();
  }

  Stream<List<VideoDetails>> _getAllVideos() {
    return FirebaseFirestore.instance
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => VideoDetails.fromDocument(doc)).toList());
  }
}
