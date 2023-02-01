import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_guide/models/school_model.dart';

class SchoolsController extends GetxController {
  var _allSchools = <SchoolDetails>[].obs;
  @override
  void onInit() {
    _allSchools.bindStream(getAllSchools());

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
  List<SchoolDetails> get allSchools {
    var schools = _allSchools.where((school) => school.showInApp == true);
    return schools.toList();
  }

  List<SchoolDetails> get allSchoolsOnHome {
    var _schoolsOnHome = <SchoolDetails>[];
    allSchools.forEach((school) {
      school.premiumFeatures.forEach(
        (premiumFeature) {
          if (premiumFeature.feature.toLowerCase() == 'schoolOnHome'.toLowerCase() &&
              DateTime.parse(premiumFeature.endDate).compareTo(DateTime.now()) > 0 &&
              school.status.toLowerCase() == "paid".toLowerCase()) {
            _schoolsOnHome.add(school);
          }
        },
      );
    });

    return _schoolsOnHome;
  }

  List<String> get allSchoolsNamesNearMe {
    var _schoolsOnHome = <String>[];
    allSchoolsOnHome.forEach((school) {
      school.premiumFeatures.forEach(
        (premiumFeature) {
          if (premiumFeature.feature.toLowerCase() == 'schoolOnHome'.toLowerCase() && DateTime.parse(premiumFeature.endDate).compareTo(DateTime.now()) > 0) {
            _schoolsOnHome.add(school.schoolName);
          }
        },
      );
    });

    return _schoolsOnHome;
  }
}
