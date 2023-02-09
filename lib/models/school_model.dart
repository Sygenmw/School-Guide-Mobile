import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolDetails {
  SchoolDetails({
    required this.address,
    required this.city,
    required this.country,
    required this.curriculums,
    required this.email,
    required this.gallery,
    required this.phone,
    required this.header,
    required this.schoolLogo,
    required this.schoolName,
    required this.showInApp,
    required this.status,
    required this.levelOfStudy,
    required this.website,
    required this.location,
    required this.id,
    required this.destination,
    required this.premiumFeatures,
  });

  final String address;
  final String city;
  final String country;
  final List<CarriculumDets> curriculums;
  final List<PremiumFeature> premiumFeatures;
  final String destination;
  final List<String> gallery;
  final String email;
  final AppLocation location;
  final String phone;
  final String header;
  final String schoolLogo;
  final String schoolName;
  final bool showInApp;
  final String status;
  final String levelOfStudy;
  final String website;
  final String id;

  factory SchoolDetails.fromDocument(DocumentSnapshot doc) => SchoolDetails(
        address: doc["address"],
        city: doc["city"],
        country: doc["country"],
        curriculums: List<CarriculumDets>.from(doc["curriculums"].map((detail) => CarriculumDets.fromMap(detail))).toList(),
        premiumFeatures: List<PremiumFeature>.from(doc["premiumFeatures"].map((detail) => PremiumFeature.fromMap(detail))).toList(),
        gallery: List<String>.from(doc["gallery"].map((x) => x)),
        email: doc["email"],
        destination: doc["destination"],
        phone: doc["phone"],
        schoolLogo: doc["schoolLogo"],
        schoolName: doc["schoolName"],
        header: doc["header"],
        showInApp: doc["showInApp"],
        status: doc["status"],
        levelOfStudy: doc["levelOfStudy"],
        website: doc["website"],
        location: AppLocation.fromMap(doc["location"]),
        id: doc.id,
      );
}

class CarriculumDets {
  CarriculumDets({
    required this.name,
    required this.price,
  });

  final String name;
  final String price;

  factory CarriculumDets.fromMap(Map<String, dynamic> doc) => CarriculumDets(
        name: doc["curriculum"],
        price: doc["price"].toString(),
      );
}

class AppLocation {
  final double lat;
  final double lng;

  AppLocation({required this.lat, required this.lng});

  factory AppLocation.fromMap(Map<String, dynamic>? doc) => AppLocation(lat: double.parse(doc!['lat']), lng: double.parse(doc['lng']));
  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class PremiumFeature {
  final String endDate;
  final String startDate;
  final String feature;

  PremiumFeature({
    required this.endDate,
    required this.startDate,
    required this.feature,
  });
  factory PremiumFeature.fromMap(Map<String, dynamic> doc) => PremiumFeature(
        endDate: doc["endDate"],
        startDate: doc["startDate"],
        feature: doc["feature"],
      );
}
