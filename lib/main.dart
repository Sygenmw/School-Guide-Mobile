import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        fontFamily: 'quicksand',
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
