import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permision;
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';
import 'package:app_settings/app_settings.dart';
import 'package:get/get.dart';

class PermissionHandler {
  static askLocationPermission() async {
    permision.PermissionStatus locationPermissionStatus = await permision.Permission.location.request();
    Location location = Location();
    bool ison = await location.serviceEnabled();
    if (locationPermissionStatus.isDenied) {
      permision.Permission.location.request();
    }
    if (locationPermissionStatus.isPermanentlyDenied) {
      permision.openAppSettings();
    }
    if (!ison) {
      bool isturnedon = await location.requestService();
      if (isturnedon) {
        //  OKAY CONTINUE
        if (locationPermissionStatus.isDenied) {
          permision.Permission.location.request();
        }
        if (locationPermissionStatus.isPermanentlyDenied) {
          permision.openAppSettings();
        }
      } else {
        Get.back();
        CustomSnackBar.showSnackBar(title: 'App Needs Location Permission', color: AppColors.errorColor, message: 'To access nearby schools, App needs to access your Location. Please Allow.');
        AppSettings.openLocationSettings();
      }
    }
  }
}
