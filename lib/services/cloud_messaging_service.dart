import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CloudMessaging extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static requestPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Accepted');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Provisional');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('Denied');
      openAppSettings();
    }
  }

  var fcmDeviceToken = ''.obs;
// token
  getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      fcmDeviceToken.value = token!;
      notifyChildrens();
      print(token);
      saveToken(fcmDeviceToken.value);
    });
  }

// save tkn
  saveToken(tkn) async {
    await FirebaseFirestore.instance.collection('userTokens').doc(tkn.substring(0, 20)).set({"token": tkn});
  }

  initInfo() {
    FlutterLocalNotificationsPlugin flutterLocalNotification = FlutterLocalNotificationsPlugin();
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialize);

    flutterLocalNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        try {
          if (details.payload != null && details.payload!.isNotEmpty) {
          } else {}
        } catch (e) {}
      },
    );

    // getfrom FB
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  // message
  getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      BigTextStyleInformation bigTextStyleInformation =
          BigTextStyleInformation(message.notification!.body.toString(), htmlFormatBigText: true, contentTitle: message.notification!.title.toString(), htmlFormatContentTitle: true);

      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'school',
        'schoolName',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await FlutterLocalNotificationsPlugin().show(0, message.notification?.title, message.notification!.body, platformChannelSpecifics, payload: message.data['title']);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}