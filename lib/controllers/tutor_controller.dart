import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/tutor_details.dart';

class TutorController extends GetxController {
  var allTutors = <TutorDetails>[].obs;

  @override
  void onInit() {
    allTutors.bindStream(_getAllTutors());
    update();
    super.onInit();
  }

  Stream<List<TutorDetails>> _getAllTutors() {
    return FirebaseFirestore.instance.collection('tutors').orderBy('name', descending: false).snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => TutorDetails.fromDocument(doc)).toList());
  }
}
