import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/school_model.dart';

class SchoolsNearController extends GetxController {
  var allSchools = <SchoolDetails>[].obs;
  @override
  void onInit() {
    allSchools.bindStream(_getAllSchools());

    notifyChildrens();
    super.onInit();
  }

  Stream<List<SchoolDetails>> _getAllSchools() {
    return FirebaseFirestore.instance.collection('schools').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => SchoolDetails.fromDocument(doc)).toList());
  }

  // calculate distance between user and school

}
