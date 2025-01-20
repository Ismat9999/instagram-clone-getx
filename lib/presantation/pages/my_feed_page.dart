import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/presantation/controllers/my_feed_controller.dart';

import '../widgets/items/item_of_post.dart';

class MyFeedPage extends StatefulWidget {
  final PageController pageController;
  const MyFeedPage({super.key,required this.pageController});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  var feedController= Get.find<MyFeedController>();

  @override
  void initState() {
    super.initState();
    feedController.addFewPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Instagram", style: TextStyle(color: Colors.black, fontFamily: "Billabong", fontSize: 30),),
        actions: [
          IconButton(
            onPressed: (){
              widget.pageController.animateToPage(
                2,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn
              );
            },
            icon: Icon(Icons.camera_alt,color: Color.fromRGBO(193,53,132,1),),
          ),
        ],
      ),
      body: GetBuilder<MyFeedController>(
        builder: (_){
          return Stack(
            children: [
              ListView.builder(
                itemCount: feedController.items.length,
                itemBuilder: (ctx, index){
                  return itemOfPost(feedController.items[index],context);
                },
              ),
            ],
          );
        },
      ),
      );
  }
}
