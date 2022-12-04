import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  var status = Permission.location.status;
  static askLocationPermission() async {
    // request location permissions
    if (await Permission.location.status.isGranted) {
    } else if (await Permission.location.status.isDenied) {
      Permission.location.request();
    } else if (await Permission.location.status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      Permission.location.request();
    }
  }
}
