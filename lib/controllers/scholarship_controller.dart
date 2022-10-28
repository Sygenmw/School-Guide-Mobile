import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/scholarship_model.dart';

class ScholarshipController extends GetxController {
  var allScholarships = <ScholarshipDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    allScholarships.bindStream(_getAllScholarships());
  }

  Stream<List<ScholarshipDetails>> _getAllScholarships() {
    return FirebaseFirestore.instance.collection('scholarships').snapshots().map((snapshot) => snapshot.docs.map((doc) => ScholarshipDetails.fromDocument(doc)).toList());
  }
}
