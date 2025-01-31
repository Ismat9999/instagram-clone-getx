import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/presantation/controllers/my_likes_controller.dart';

import '../widgets/items/item_of_likes.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({super.key});

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  var likesController = Get.find<MyLikesController>();

  @override
  void initState() {
    super.initState();
    likesController.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Likes"),
      ),
      body: GetBuilder<MyLikesController>(
        builder: (_) {
          return Stack(children: [
            ListView.builder(
              itemCount: likesController.items.length,
              itemBuilder: (ctx, index) {
                return itemOfLikes(likesController.items[index],likesController ,context);
              },
            ),
            likesController.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink(),
          ]);
        },
      ),
    );
  }
}
