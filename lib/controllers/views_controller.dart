import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/views_model.dart';

class ViewsController extends GetxController {
  var allViews = <ViewDetails>[].obs;
  @override
  void onInit() {
    allViews.bindStream(_getViews());
    super.onInit();
  }

  // get the views
  Stream<List<ViewDetails>> _getViews() {
    return FirebaseFirestore.instance.collection('blogViews').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => ViewDetails.fromDocument(doc)).toList());
  }
}
