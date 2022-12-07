import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreenView extends StatefulWidget {
  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  Future delayApp() async {
    await Future.delayed(Duration(milliseconds: 5000));
  }

  @override
  void initState() {
    delayApp().then((value) {
      Get.offAll(() => Home());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  GlowingProgressIndicator(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(AppImages.logo, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                launchUrl(Uri.parse('https://sygenmw.com/'));
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(text: 'Crafted with ', style: TextStyle(fontSize: 40, fontFamily: 'amsterdam', color: AppColors.primaryColor), children: <TextSpan>[
                      TextSpan(text: '❤️ ', style: TextStyle(fontSize: 22)),
                      TextSpan(text: 'by ', style: TextStyle(fontFamily: 'amsterdam', fontSize: 40)),
                      TextSpan(text: 'Sygen ', style: TextStyle(fontFamily: 'quicksand', fontWeight: FontWeight.bold, fontSize: 24))
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
