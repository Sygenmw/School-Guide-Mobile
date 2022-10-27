import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/edu_blog_controller.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/controllers/video_controller.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/all_controllers.dart';
import 'firebase_options.dart';

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
  });

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.grey,
    statusBarIconBrightness: Brightness.dark,
  ));
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
      theme: ThemeData(
        fontFamily: 'quicksand',
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
