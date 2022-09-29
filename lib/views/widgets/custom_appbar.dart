import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';

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
            BorderRadius.only(bottomRight: isHomeAppBar ? const Radius.circular(0) : const Radius.circular(30), bottomLeft: isHomeAppBar ? const Radius.circular(0) : const Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: backIconAvailable
                  ? () {
                      HapticFeedback.vibrate();
                      Get.back();
                    }
                  : () {},
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
                  style: TextStyle(fontFamily: 'quicksand', fontSize: 25, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                ),
                Text(
                  AppStrings.appSubTitle,
                  style: TextStyle(fontSize: 16, color: AppColors.black),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.vibrate();
                // search
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              child: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
                size: 27,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? Get.back() : query = '';
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.primaryColor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.primaryColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResultsList = [
      'Sygen Tim',
      'Sygen Tony',
      'Sygen Sebastian',
      'Sygen Dan',
      'Sygen Everyone',
      'Sygen Apps',
    ];

    List<String> suggestions = searchResultsList.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
          title: Text(suggestions[index]),
        );
      },
    );
  }
}
