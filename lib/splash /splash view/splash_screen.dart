
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_project/splash%20/controller/splash_controller.dart';

class SplashScreen extends GetView {
  
  final SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.white,
      child: const Image(image: AssetImage('lib/assets/new splash.png')),
    );
  }
}
