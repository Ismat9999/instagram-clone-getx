import 'package:get/get.dart';
import 'package:instaclone/core/services/db_service.dart';

import '../../data/datasources/models/member_model.dart';

class MySearchController extends GetxController {
  bool isLoading = false;
  List<Member> items = [];


  apiLoadMembers(String keyword)async{
    isLoading=true;
    update();

    var results=await DBService.searchMembers(keyword);
    items = results;
    isLoading= false;
    update();
  }

  void followMember(Member someone)async{
    isLoading=true;
    update();

    await DBService.followMember(someone);
    someone.followed=true;

    isLoading=false;
    update();

    // Store someone's posts to my feed
    await DBService.storePostsToMyFeed(someone);
  }

  void unFollowMember(Member someone)async{
    isLoading=true;
    update();

    await DBService.unFollowMember(someone);
    someone.followed=false;

    isLoading=false;
    update();

    // Remove someone's posts to my feed
    DBService.removePostsToMyFeed(someone);
  }
}
