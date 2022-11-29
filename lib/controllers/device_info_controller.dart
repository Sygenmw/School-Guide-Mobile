import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  Future<AndroidDeviceInfo> getInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }
}
