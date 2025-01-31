import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/core/services/auth_service.dart';
import 'package:instaclone/core/services/db_service.dart';
import 'package:instaclone/core/services/file_service.dart';
import 'package:instaclone/core/services/log_service.dart';
import 'package:instaclone/core/services/prefs_service.dart';
import 'package:instaclone/core/services/utils_service.dart';
import 'package:instaclone/data/datasources/models/member_model.dart';
import 'package:instaclone/data/datasources/models/post_model.dart';
import 'package:instaclone/presantation/pages/sign_in_page.dart';

class MyProfileController extends GetxController {
  String? member_image;
  String? member_fullname = "Ismatilla";
  String? member_email = "ismatilla@gmail.com";

  ImagePicker picker = ImagePicker();

  int count_posts = 0;
  int count_following = 0;
  int count_follower = 0;

  int axisCount = 2;

  List<Post> items = [];

  apiLoadPosts() async {
    var results = await DBService.loadPosts();
    items = results;
    count_posts = items.length;
    update();
  }

  apiLoadMember() async {
    Member member = await DBService.loadMember();

    member_fullname = member.fullname;
    member_email = member.email;
    member_image = member.img_url;
    count_follower = member.followers_count;
    count_following= member.following_count;
    update();
  }

  void changedAxisCount(int axisCount) {
    this.axisCount = axisCount;
    update();
  }

  void doSignOut(BuildContext context) async {
    var result = await UtilsService.dialogCommon(
        context, "Sign Out", "Do you want to sign out!", false);
    LogService.i(result.toString());
    if (result) {
      await AuthService.signOutUser();
      PrefsService.removeUserId();
      Get.off(SignInPage());
    }
  }

  pickFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(image != null){
      var pickedImage= File(image.path);

      String downloadUrl = await FileService.uploadUserImage(pickedImage);
      Member member =await DBService.loadMember();
      member.img_url=downloadUrl;
      await DBService.updateMember(member);
      apiLoadMember();
    }
  }
}
