import 'package:get/get.dart';
import 'package:instaclone/data/datasources/models/post_model.dart';

class MyLikesController extends GetxController {
  bool isLoading = false;
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
}
