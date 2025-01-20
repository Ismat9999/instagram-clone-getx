

import 'package:get/get.dart';

import '../../presantation/controllers/home_controller.dart';
import '../../presantation/controllers/signin_controller.dart';
import '../../presantation/controllers/signup_controller.dart';
import '../../presantation/controllers/splash_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(()=> HomeController(), fenix: true);
    Get.lazyPut(()=> SplashController(), fenix: true);
    Get.lazyPut(()=> SignInController(), fenix: true);
    Get.lazyPut(()=> SignUpController(), fenix: true);
  }
}