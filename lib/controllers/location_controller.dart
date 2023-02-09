import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  var _latitude = 0.0.obs;

  var _longitude = 0.0.obs;

   determinePosimtion() {
  Location location = Location();
    location.getLocation().then((value) {
      _longitude.value = value.longitude!;
      _latitude.value = value.latitude!;
      notifyChildrens();
    });
    Stream<LocationData> changedLocation = location.onLocationChanged;

    changedLocation.listen((event) {
      _longitude.value = event.longitude!;
      _latitude.value = event.latitude!;
    });
  }
}
