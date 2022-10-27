import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolDetails {
  SchoolDetails({
    required this.address,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.details,
    required this.email,
    required this.phone,
    required this.schoolLogo,
    required this.schoolName,
    required this.showInApp,
    required this.status,
    required this.curriculum,
    required this.updatedAt,
    required this.website,
  });

  final String address;
  final String city;
  final String country;
  final Timestamp createdAt;
  final List<String> curriculum;
  final List<Detail> details;
  final String email;
  final String phone;
  final String schoolLogo;
  final String schoolName;
  final bool showInApp;
  final String status;
  final Timestamp updatedAt;
  final String website;

  factory SchoolDetails.fromDocument(DocumentSnapshot doc) => SchoolDetails(
        address: doc["address"],
        city: doc["city"],
        country: doc["country"],
        createdAt: doc["createdAt"],
        curriculum: List<String>.from(doc["curriculum"].map((x) => x)),
        details: List<Detail>.from(doc["details"].map((detail) => Detail.fromMap(detail))).toList(),
        email: doc["email"],
        phone: doc["phone"],
        schoolLogo: doc["schoolLogo"],
        schoolName: doc["schoolName"],
        showInApp: doc["showInApp"],
        status: doc["status"],
        updatedAt: doc["updatedAt"],
        website: doc["website"],
      );
}

class Detail {
  Detail({
    required this.level,
    required this.price,
    required this.type,
  });

  final String level;
  final String price;
  final String type;

  factory Detail.fromMap(Map<String, dynamic> doc) => Detail(
        level: doc["level"],
        price: doc["price"],
        type: doc["type"],
      );
}
