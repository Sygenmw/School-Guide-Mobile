import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/views_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';

class ViewsController extends GetxController {
  static addView({required ViewDetails viewDetails}) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('blogViews').doc(viewDetails.blogID);

      docRef.set(viewDetails.toDocument());
    } catch (e) {
      CustomSnackBar.showSnackBar(color: AppColors.errorColor, title: 'UNABLE TO COMPLETE ACTION', message: 'Cannot Add Like now! Try again');
    }
  }

  // get the views
  Stream<List<ViewDetails>> getViews() {
    return FirebaseFirestore.instance.collection('blogViews').snapshots().map((snapshot) => snapshot.docs.map((doc) => ViewDetails.fromDocument(doc)).toList());
  }
}
