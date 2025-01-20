
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/presantation/pages/home_page.dart';
import 'package:instaclone/presantation/pages/sign_in_page.dart';

class SignUpController extends GetxController{
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  var fullnameController =TextEditingController();
  var cpasswordController=TextEditingController();

  bool isLoading= false;

  void callHomePage() {
    Get.off(HomePage());
  }

  void callSignInPage() {
    Get.off(SignInPage());
  }
}