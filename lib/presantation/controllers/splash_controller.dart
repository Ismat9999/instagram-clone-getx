import 'dart:async';

import 'package:get/get.dart';
import 'package:instaclone/core/services/auth_service.dart';
import 'package:instaclone/presantation/pages/home_page.dart';

import '../pages/sign_in_page.dart';

class SplashController extends GetxController {
  callNextPage() {
    if (AuthService.isLoggedIn()) {
      Get.off(HomePage());
    } else {
      Get.off(SignInPage());
    }
  }

  void initTimer() {
    Timer(const Duration(seconds: 2), () {
      callNextPage();
    });
  }
}
