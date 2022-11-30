import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/banner.dart';

class BannerController extends GetxController {
  var allBanners = <BannerDetails>[].obs;
  // var validBanners = <BannerDetails>[].obs;
  int get count => allBanners.length;

  @override
  void onInit() {
    allBanners.forEach((banner) {
      if (banner.deadline.compareTo(Timestamp.now()) > 0) {
        allBanners.bindStream(_getAllBanners());
      } else {}
    });

    notifyChildrens();
    super.onInit();
  }

  @override
  void onReady() {
    allBanners.bindStream(_getAllBanners());

    notifyChildrens();
    super.onReady();
  }

  // void getBanners() {
  //   for (var banner in allBanners) {
  //     if (banner.dateLine.compareTo(Timestamp.now()) > 0) {
  //       validBanners.add(banner);
  //       print('NOT YET DATELINE : ${banner.dateLine.compareTo(Timestamp.now())}');
  //       notifyChildrens();
  //     } else {
  //       print('Dateline Passed${banner.dateLine.compareTo(Timestamp.now())}');
  //     }
  //   }
  // }

  Stream<List<BannerDetails>> _getAllBanners() {
    return FirebaseFirestore.instance.collection('banners').snapshots().map((QuerySnapshot snapshot) => snapshot.docs
        .map(
          (DocumentSnapshot doc) => BannerDetails.fromDocument(doc),
        )
        .toList());
  }
}