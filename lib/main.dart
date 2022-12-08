import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:school_guide/views/splash_screen.dart';
import 'controllers/all_controllers.dart';
import 'firebase_options.dart';

//PERMISSION HANDLER

// ...
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
  });

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(22, 255, 255, 255),
    statusBarIconBrightness: Brightness.dark,
  ));
  await EduBlogController.init();
  runApp(const SchoolGuide());
}

class SchoolGuide extends StatelessWidget {
  const SchoolGuide({Key? key}) : super(key: key);

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
