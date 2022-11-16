import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/curriculum_model.dart';

class CurriculumController extends GetxController{
  var allCurriculums = <CurriculumDetails>[].obs;

  @override
  void onInit() {
    allCurriculums.bindStream(_getCurriculums());
    super.onInit();
  }

  Stream<List<CurriculumDetails>> _getCurriculums(){
    return FirebaseFirestore.instance.collection('curriculum').snapshots().map((snap) => snap.docs.map((e) => CurriculumDetails.fromDocument(e)).toList());
  }
}