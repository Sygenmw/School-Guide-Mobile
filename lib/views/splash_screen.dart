import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/views/homepage.dart';

class SplashScreenView extends StatefulWidget {
  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  Future delayApp() async {
    await Future.delayed(Duration(milliseconds: 4200));
  }

  @override
  void initState() {
    delayApp().then((value) {
      Get.to(() => Home());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.size.height,
            child: Image.asset(
              'assets/images/splash.gif',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
