import 'package:get/get.dart';

class HomePageController extends GetxController {
  RxBool isDog = true.obs;

  changeValue() {
    isDog.value = !isDog.value;
  }
}
