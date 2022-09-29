import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/banner.dart';

class BannerController extends GetxController {
  var allBanners = <BannerDetails>[].obs;
  int get count => allBanners.length;

  @override
  void onInit() {
    super.onInit();
    allBanners.bindStream(_getAllBanners());
  }

  Stream<List<BannerDetails>> _getAllBanners() {
    return FirebaseFirestore.instance.collection('growers').snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot doc) => BannerDetails.fromDocument(doc)).toList();
    });
  }
}
