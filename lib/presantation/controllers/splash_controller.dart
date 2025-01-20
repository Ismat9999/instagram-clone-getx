
import 'dart:async';

import 'package:get/get.dart';

import '../pages/sign_in_page.dart';

class SplashController extends GetxController{

  callNextPage(){
    Get.off(SignInPage());
  }

  void initTimer(){
    Timer(const Duration(seconds: 2),(){
      callNextPage();
    });
  }
}