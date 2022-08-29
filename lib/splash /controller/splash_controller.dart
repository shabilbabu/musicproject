import 'dart:async';
import 'package:get/get.dart';
import 'package:music_project/bottom/bottom_view/bottom_nav.dart';

class SplashController extends GetxController {
  SplashController() {
    timeFunction();
  }

  timeFunction() {
    Timer(const Duration(seconds: 3), () {
      Get.off(BottomNav());
    });
  }
}
