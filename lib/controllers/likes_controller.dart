import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/likes_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';

class LikesController extends GetxController {
  static addLike({required LikeDetails likeDetails}) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('blogLikes').doc(likeDetails.id);

      var values = likeDetails.toDocument();
      docRef.set({
        "allLikes": FieldValue.arrayUnion([values])
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(color: AppColors.errorColor, title: 'UNABLE TO COMPLETE ACTION', message: 'Cannot Add Like now! Try again');
    }
  }

  static deleteLike({required LikeDetails likeDetails}) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('blogLikes').doc(likeDetails.id);
      final tempRef = FirebaseFirestore.instance.collection('blogLikes').doc(likeDetails.id);

      var values = likeDetails.toDocument();

      docRef.delete();
      tempRef.set({
        "allLikes": FieldValue.arrayUnion([values])
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(color: AppColors.errorColor, title: 'UNABLE TO COMPLETE ACTION', message: 'Cannot Add Like now! Try again');
    }
  }

  // get the likes
  Stream<List<LikeDetails>> getLikes() {
    return FirebaseFirestore.instance.collection('blogLikes').snapshots().map((snapshot) => snapshot.docs.map((doc) => LikeDetails.fromDocument(doc)).toList());
  }
}
