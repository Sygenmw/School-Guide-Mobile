import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolDetails {
  SchoolDetails({
    required this.address,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.curriculums,
    required this.email,
    required this.gallery,
    required this.phone,
    required this.schoolLogo,
    required this.schoolName,
    required this.showInApp,
    required this.status,
    required this.levelOfStudy,
    required this.website,
    required this.id,
    required this.destination,
  });

  final String address;
  final String city;
  final String country;
  final Timestamp createdAt;
  final List<CarriculumDets> curriculums;
  final String destination;
  final List<String> gallery;
  final String email;
  final String phone;
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
        createdAt: doc["createdAt"],
        curriculums: List<CarriculumDets>.from(doc["curriculums"].map((detail) => CarriculumDets.fromMap(detail))).toList(),
        gallery: List<String>.from(doc["gallery"].map((x) => x)),
        email: doc["email"],
        destination: doc["destination"],
        phone: doc["phone"],
        schoolLogo: doc["schoolLogo"],
        schoolName: doc["schoolName"],
        showInApp: doc["showInApp"],
        status: doc["status"],
        levelOfStudy: doc["levelOfStudy"],
        website: doc["website"],
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
        price: doc["price"],
      );
}
