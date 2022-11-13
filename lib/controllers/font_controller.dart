import 'package:get/get.dart';

class FontController extends GetxController {
  var fontSize = 14.obs;

  void increase() {
    fontSize++;
    notifyChildrens();
  }

  void decrease() {
    fontSize.value == 14 ? fontSize.value = 14 : fontSize--;
    notifyChildrens();
  }
}
