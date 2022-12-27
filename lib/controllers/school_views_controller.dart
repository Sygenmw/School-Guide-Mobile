import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/views_model.dart';

class SchoolViewsController extends GetxController {
  var allSchoolViews = <ViewDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    allSchoolViews.bindStream(_getAllSchoolViews());
  }

  Stream<List<ViewDetails>> _getAllSchoolViews() {
    return FirebaseFirestore.instance.collection('schoolViews').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => ViewDetails.fromDocument(doc)).toList());
  }
}
