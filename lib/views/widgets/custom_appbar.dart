import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/schools_near_controller.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/school_info.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.backIconAvailable = true, this.isHomeAppBar = false, this.showAbout = true}) : super(key: key);
  final bool backIconAvailable;
  final bool isHomeAppBar;
  final bool showAbout;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isHomeAppBar ? 1 : 0,
      margin: const EdgeInsets.only(top: 27),
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(bottomRight: isHomeAppBar ? const Radius.circular(0) : const Radius.circular(0), bottomLeft: isHomeAppBar ? const Radius.circular(0) : const Radius.circular(0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backIconAvailable
                ? Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          HapticFeedback.vibrate();
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 35,
                            color: AppColors.primaryColor,
                          ),
                        )),
                  )
                : GestureDetector(
                    onTap: (() {
                      launchUrl(Uri.parse('https://sygenmw.com/'), mode: LaunchMode.externalApplication);
                    }),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  AppStrings.appTitle,
                  style: TextStyle(fontFamily: 'quicksand', fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                ),
                Text(
                  AppStrings.appSubTitle,
                  style: TextStyle(fontSize: 15, color: AppColors.black),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      HapticFeedback.vibrate();
                      showSearch(context: context, delegate: CustomSearchDelegate());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.search,
                        size: 35,
                        color: AppColors.primaryColor,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(85);
}

class CustomSearchDelegate extends SearchDelegate {
  final SchoolsNearController schoolController = Get.find();
  final List<SchoolDetails> allSchools = [];
  final List<String> schoolNames = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              HapticFeedback.vibrate();
              query.isEmpty ? Get.back() : query = '';
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.clear,
                size: 35,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          HapticFeedback.vibrate();
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    schoolController.allSchools.forEach((element) {
      schoolNames.contains(element.schoolName) ? {} : schoolNames.add(element.schoolName);
      allSchools.contains(element) ? {} : allSchools.add(element);
    });
    List<String> searchResultsList = schoolNames;

    List<String> suggestions = searchResultsList.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return suggestions.isEmpty
        ? query.isEmpty
            ? Container(
                child: Center(
                    child: CustomText('We do not have schools at present! Try again later.',
                        textAlign: TextAlign.center, pLeft: 0, pRight: 0, pBottom: 0, pTop: 0, needsIcon: false, color: AppColors.primaryColor)),
              )
            : Container(
                child: Center(
                    child: CustomText('$query does not match any of our records! Pleases try again!',
                        textAlign: TextAlign.center, pLeft: 0, pRight: 0, pBottom: 0, pTop: 0, needsIcon: false, color: AppColors.primaryColor)),
              )
        : ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: index == 0 ? const EdgeInsets.only(top: 20.0) : const EdgeInsets.only(top: 0.0),
                child: Card(
                  color: AppColors.primaryColor,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: SizedBox(
                        width: 60,
                        height: 100,
                        child: Icon(
                          Icons.school_rounded,
                          color: AppColors.white,
                        )),
                    onTap: () {
                      query = suggestions[index];
                      Get.back();
                      Get.to(() => SchoolInfo(
                            school: allSchools.elementAt(schoolNames.indexOf(query)),
                          ));
                    },
                    title: CustomText(
                      suggestions[index],
                      pLeft: 0,
                      pTop: 0,
                      pBottom: 0,
                      needsIcon: false,
                      textAlign: TextAlign.left,
                      color: AppColors.white,
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class SuggestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      child: ListTile(),
    );
  }
}
