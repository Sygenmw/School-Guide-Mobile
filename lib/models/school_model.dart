import 'package:cloud_firestore/cloud_firestore.dart';

class School {
  School({
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
    required this.tags,
    required this.website,
  });

  final String address;
  final String city;
  final String country;
  final String createdAt;
  final List<Detail> details;
  final String email;
  final String phone;
  final String schoolLogo;
  final String schoolName;
  final bool showInApp;
  final String status;
  final List<String> tags;
  final String website;

  factory School.fromDocument(DocumentSnapshot doc) => School(
        address: doc["address"],
        city: doc["city"],
        country: doc["country"],
        createdAt: doc["createdAt"],
        details: List<Detail>.from(doc["details"].map((detail) => Detail.fromDocument(detail))),
        email: doc["email"],
        phone: doc["phone"],
        schoolLogo: doc["schoolLogo"],
        schoolName: doc["schoolName"],
        showInApp: doc["showInApp"],
        status: doc["status"],
        tags: List<String>.from(doc["tags"].map((x) => x)),
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
  final int price;
  final String type;

  factory Detail.fromDocument(DocumentSnapshot doc) => Detail(
        level: doc["level"],
        price: doc["price"],
        type: doc["type"],
      );
}
