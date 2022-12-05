import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlowingProgressIndicator(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          AppImages.logo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Find the \nright school for your child.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse('https://sygenmw.com/'), mode: LaunchMode.externalApplication);
                        },
                        child: Text(
                          'Sygen\nCopyright©️ 2022',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
