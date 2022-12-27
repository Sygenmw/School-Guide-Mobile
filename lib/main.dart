import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:school_guide/views/home/edu_blog.dart';
import 'package:school_guide/views/home/scholarships.dart';
import 'package:school_guide/views/home/school_directiory.dart';
import 'firebase_options.dart';
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//
import 'package:school_guide/controllers/edu_blog_controller.dart';
import 'package:school_guide/views/splash_screen.dart';
//
import 'package:get/get.dart';
import 'package:school_guide/controllers/initialize_controllers.dart';

//
//PERMISSION HANDLER
const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'Description',
  importance: Importance.high,
  playSound: true,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

// ...
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Controller.initializeControllers();
  });
  // get notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  //
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(22, 255, 255, 255),
    statusBarIconBrightness: Brightness.dark,
  ));
  await EduBlogController.init();
  runApp(const SchoolGuide());
}

class SchoolGuide extends StatefulWidget {
  const SchoolGuide({Key? key}) : super(key: key);

  @override
  State<SchoolGuide> createState() => _SchoolGuideState();
}

class _SchoolGuideState extends State<SchoolGuide> {
  //
  Future<void> subscribeToTopics() async {
    await FirebaseMessaging.instance.subscribeToTopic('other').then((value) => print('in'));
    await FirebaseMessaging.instance.subscribeToTopic('schoolNotification');
    await FirebaseMessaging.instance.subscribeToTopic('scholarshipNotification');
    await FirebaseMessaging.instance.subscribeToTopic('eduBlogNotification');
    // initializer();
    initializePlatformSpecifics();
  }

  @override
  void initState() {
    super.initState();
    subscribeToTopics();
    FirebaseMessaging.onBackgroundMessage((message) {
      RemoteNotification notification = message.notification!;

      return flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationChannel.id,
              androidNotificationChannel.name,
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationChannel.id,
              androidNotificationChannel.name,
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      //  PUSH TO PAGE
      if (notification.title!.toLowerCase().contains('scholarship')) {
        Get.to(() => Scholarships());
      } else if (notification.title!.toLowerCase().contains('school')) {
        Get.to(() => SchoolDirectory());
      } else if (notification.title!.toLowerCase().contains('blog')) {
        Get.to(() => EducationBlog());
      }
    });
  }

  initializePlatformSpecifics() {
    InitializationSettings androidInitSettings = InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    flutterLocalNotificationsPlugin.initialize(androidInitSettings);
  }

  //
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      title: 'School Guide Malawi',
      theme: ThemeData(
        fontFamily: 'quicksand',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(),
    );
  }
}
