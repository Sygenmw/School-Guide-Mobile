import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_guide/views/home/edu_blog.dart';
import 'package:school_guide/views/home/scholarships.dart';
import 'package:school_guide/views/home/school_directiory.dart';

class CloudMessaging extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  requestPermission() async {
    await Permission.notification.isDenied.then((value) {
      Permission.notification.request();
      print('Permision status is : $value');
    });
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
      // step 2 here
      messaging.getInitialMessage().then((RemoteMessage? message) {
        if (message!.notification!.title!.toLowerCase().contains('scholarship')) {
          Get.to(() => Scholarships());
        } else if (message.notification!.title!.toLowerCase().contains('school')) {
          Get.to(() => SchoolDirectory());
        } else if (message.notification!.title!.toLowerCase().contains('blog')) {
          Get.to(() => EducationBlog());
        }

        debugPrint('SOmething : ${settings.authorizationStatus.name}');
      });
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('Provisional');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('Denied');
      openAppSettings();
    }
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");
  }

  var fcmDeviceToken = ''.obs;
// token
  getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      fcmDeviceToken.value = token!;
      notifyChildrens();
      debugPrint(token);
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
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });
  }

  // message
  getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

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
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
