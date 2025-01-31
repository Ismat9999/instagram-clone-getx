import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/core/services/db_service.dart';
import 'package:instaclone/data/datasources/models/post_model.dart';

import '../../core/services/utils_service.dart';

class MyLikesController extends GetxController {
  bool isLoading = false;
  List<Post> items = [];

  apiLoadLikes() async {
    isLoading = true;
    update();

    var results = await DBService.loadLikes();
    items = results;
    isLoading = false;
    update();
  }

   void apiUnlikePost(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, false);

    apiLoadLikes();
  }
  apiRemovePost(Post post) async {
    isLoading= true;
    update();

    await DBService.removePosts(post);

    apiLoadLikes();
  }

  void dialogRemovePost(BuildContext context, Post post)async{
    var result = await UtilsService.dialogCommon(context, "Remove", "Do you want to remove this post?", false);
    if(result){
      apiRemovePost(post);
    }
  }
}
