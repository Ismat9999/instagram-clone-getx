import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/core/services/log_service.dart';
import 'package:instaclone/core/services/prefs_service.dart';
import 'package:instaclone/presantation/controllers/home_controller.dart';
import 'package:instaclone/presantation/pages/my_feed_page.dart';
import 'package:instaclone/presantation/pages/my_likes_page.dart';
import 'package:instaclone/presantation/pages/my_profile_page.dart';
import 'package:instaclone/presantation/pages/my_search_page.dart';
import 'package:instaclone/presantation/pages/my_upload_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeController= Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  loadUserId()async{
    var uuid= await PrefsService.loadUserId();
    LogService.i(uuid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller){
        return Scaffold(
          body: PageView(
            onPageChanged:(int index){
              homeController.onPageChanged(index);
            },
            controller: homeController.pageController,
            children: [
              MyFeedPage(pageController: homeController.pageController,),
            MySearchPage(
            ),
            MyUploadPage(pageController: homeController.pageController,),
              MyLikesPage(),
              MyProfilePage(),
            ],
          ),
          bottomNavigationBar: CupertinoTabBar(
            onTap: (int index){
              homeController.onTap(index);
              homeController.pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            currentIndex: homeController.currentTap,
            activeColor: Color.fromRGBO(193, 53, 132, 1),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 32,),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,size: 32,),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box,size: 32,),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite,size: 32,),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,size: 32,),
              ),
            ],
          ),
        );
      },
    );
  }
}
