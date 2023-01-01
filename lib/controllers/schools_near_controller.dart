import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/school_model.dart';

class SchoolsNearController extends GetxController {
  var allSchools = <SchoolDetails>[].obs;
  @override
  void onInit() {
    allSchools.bindStream(getAllSchools());

    notifyChildrens();
    super.onInit();
  }

  static Stream<List<SchoolDetails>> getAllSchools() {
    return FirebaseFirestore.instance
        .collection('schools')
        .orderBy('schoolName', descending: false)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => SchoolDetails.fromDocument(doc)).toList());
  }

  // calculate distance between user and school

}
