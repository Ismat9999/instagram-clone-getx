import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/core/services/auth_service.dart';
import 'package:instaclone/core/services/log_service.dart';
import 'package:instaclone/core/services/prefs_service.dart';
import 'package:instaclone/core/services/utils_service.dart';
import 'package:instaclone/data/datasources/models/post_model.dart';
import 'package:instaclone/presantation/pages/sign_in_page.dart';

class MyProfileController extends GetxController {
  String? member_image;
  String? member_fullname = "Ismatilla";
  String? member_email = "ismatilla@gmail.com";

  int count_posts = 0;
  int count_following = 0;
  int count_follow = 0;

  int axisCount = 2;

  List<Post> items = [];

  void addFewPosts() {
    Post post = Post("How to learn flutter faster?",
        "https://plus.unsplash.com/premium_photo-1734577272140-9f4c41a9fedd?q=80&w=1854&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    post.fullname = "Ismatilla";
    post.date = "2025.01.02 2PM";
    post.mine = true;
    post.img_user =
        "https://images.unsplash.com/photo-1737111869094-80ed40daca91?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    Post post2 = Post("BEK BEK",
        "https://images.unsplash.com/photo-1735258083208-564747ddb1c6?q=80&w=2075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    post2.fullname = "Erik";
    post2.date = "2025.02.03 3PM";
    post2.mine = false;

    items.add(post);
    items.add(post2);
    items.add(post);
    items.add(post2);
    items.add(post);
    items.add(post2);
  }

  void changedAxisCount(int axisCount) {
    this.axisCount = axisCount;
    update();
  }

  void doSignOut(BuildContext context)async{
    var result = await UtilsService.dialogCommon(context, "Sign Out", "Do you want to sign out/", false);
    LogService.i(result.toString());
    if(result){
      await AuthService.signOutUser();
      PrefsService.removeUserId();
      Get.off(SignInPage());
    }
  }
}
