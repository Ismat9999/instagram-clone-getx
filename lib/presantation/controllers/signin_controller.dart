
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instaclone/presantation/pages/home_page.dart';
import 'package:instaclone/presantation/pages/sign_up_page.dart';

class SignInController extends GetxController{
  var emailController= TextEditingController();
  var passwordController= TextEditingController();

  bool isLoading= false;

  void callHomePage() {
    Get.off(HomePage());
  }

  void callSignUpPage() {
    Get.off(SignUpPage());
  }
}