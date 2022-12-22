import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/agent_controller.dart';
import 'package:school_guide/controllers/curriculum_controller.dart';
import 'package:school_guide/controllers/edu_blog_controller.dart';
import 'package:school_guide/controllers/font_controller.dart';
import 'package:school_guide/controllers/scholarship_controller.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/controllers/tutor_controller.dart';
import 'package:school_guide/controllers/video_controller.dart';
import 'package:school_guide/controllers/views_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:school_guide/services/cloud_messaging_service.dart';
import 'package:school_guide/views/splash_screen.dart';
import 'controllers/all_controllers.dart';
import 'firebase_options.dart';

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
    Get.put(BannerController());
    Get.put(SchoolsNearController());
    Get.put(EduBlogController());
    Get.put(VideoController());
    Get.put(ScholarshipController());
    Get.put(AgentController());
    Get.put(FontController());
    Get.put(CurriculumController());
    Get.put(TutorController());
    Get.put(ViewsController());
    Get.put(CloudMessaging());
  });
  // get notifications
  // await FirebaseMessaging.instance.getInitialMessage();
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
  initializer() async {
    await FirebaseMessaging.instance.subscribeToTopic('schoolNotification');
    await FirebaseMessaging.instance.subscribeToTopic('scholarshipNotification');
    await FirebaseMessaging.instance.subscribeToTopic('eduBlogNotification');
    await FirebaseMessaging.instance.subscribeToTopic('other');
  }

  //
  Future<void> firstTimeRunningChecker() async {
    await FirebaseMessaging.instance.subscribeToTopic('other').then((value) => print('in'));

    initializer();
    initializePlatformSpecifics();
  }

  @override
  void initState() {
    //showNotification();
    super.initState();
    firstTimeRunningChecker();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title!),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body!),
                    SizedBox(height: 20),
                    Container(
                        height: 30,
                        child: Center(
                          child: Material(
                              //Wrap with Material
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              elevation: 0.0,
                              color: Colors.black,
                              clipBehavior: Clip.antiAlias, // Add This
                              child: MaterialButton(
                                splashColor: Colors.green,
                                elevation: 50,
                                minWidth: 250.0,
                                height: 30,
                                color: Colors.purple,
                                child: new Text("Open Notifications", style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                                onPressed: () {
                                  //  GOTO PAGE
                                },
                              )),
                        ))
                  ],
                ),
              ),
            );
          });

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationChannel.id,
              androidNotificationChannel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      //  PUSH TO PAGE
      AndroidNotification android = message.notification!.android!;
    });
  }

  Future selectNotification(String payload) async {
    print('notification payload: $payload');
    Get.back();
  }

  initializePlatformSpecifics() {
    InitializationSettings androidInitSettings = InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    flutterLocalNotificationsPlugin.initialize(androidInitSettings);
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(0, "Testing", "How you doin?",
        NotificationDetails(android: AndroidNotificationDetails(androidNotificationChannel.id, androidNotificationChannel.name, importance: Importance.high, color: Colors.blue, playSound: true, icon: '@mipmap/ic_launcher')));
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
