

import 'package:get/get.dart';
import 'package:instaclone/presantation/controllers/my_feed_controller.dart';
import 'package:instaclone/presantation/controllers/my_likes_controller.dart';
import 'package:instaclone/presantation/controllers/my_profile_controller.dart';
import 'package:instaclone/presantation/controllers/my_search_controller.dart';
import 'package:instaclone/presantation/controllers/my_upload_controller.dart';

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
    Get.lazyPut(()=> MyUploadController(), fenix: true);
    Get.lazyPut(()=> MyFeedController(), fenix: true);
    Get.lazyPut(()=> MyLikesController(), fenix: true);
    Get.lazyPut(()=> MySearchController(), fenix: true);
    Get.lazyPut(()=> MyProfileController(), fenix: true);
  }
}