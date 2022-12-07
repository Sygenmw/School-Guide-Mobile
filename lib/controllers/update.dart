// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:url_launcher/url_launcher.dart';

// const APP_STORE_URL = 'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
// const PLAY_STORE_URL = 'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

// versionCheck(context) async {
//   //Get Current installed version of app
//   final PackageInfo info = await PackageInfo.fromPlatform();
//   double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

//   //Get Latest version info from firebase config
//   final RemoteConfig remoteConfig = await RemoteConfig.instance;

//   try {
//     // Using default duration to force fetching from remote server.
//     await remoteConfig.fetch(expiration: const Duration(seconds: 0));
//     await remoteConfig.activateFetched();
//     remoteConfig.getString('force_update_current_version');
//     double newVersion = double.parse(remoteConfig.getString('force_update_current_version').trim().replaceAll(".", ""));
//     if (newVersion > currentVersion) {
//       _showVersionDialog(context);
//     }
//   } on FetchThrottledException catch (exception) {
//     // Fetch throttled.
//     print(exception);
//   } catch (exception) {
//     print('Unable to fetch remote config. Cached or default values will be '
//         'used');
//   }
// }

// //Show Dialog to force user to update
// _showVersionDialog(context) async {
//   await showDialog<String>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       String title = "New Update Available";
//       String message = "There is a newer version of app available please update it now.";
//       String btnLabel = "Update Now";
//       String btnLabelCancel = "Later";
//       return Platform.isIOS
//           ? new CupertinoAlertDialog(
//               title: Text(title),
//               content: Text(message),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(btnLabel),
//                   onPressed: () => _launchURL(Config.APP_STORE_URL),
//                 ),
//                 TextButton(
//                   child: Text(btnLabelCancel),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             )
//           : new AlertDialog(
//               title: Text(title),
//               content: Text(message),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(btnLabel),
//                   onPressed: () => _launchURL(Config.PLAY_STORE_URL),
//                 ),
//                 TextButton(
//                   child: Text(btnLabelCancel),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             );
//     },
//   );
// }

// _launchURL(String url) async {
//   launchUrl(Uri.parse(url));
// }
