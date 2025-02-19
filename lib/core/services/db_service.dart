import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/core/services/utils_service.dart';

import '../../data/datasources/models/member_model.dart';
import '../../data/datasources/models/post_model.dart';
import 'auth_service.dart';
import 'log_service.dart';

class DBService {
  static final _firestore = FirebaseFirestore.instance;

  static String folder_users = "users";
  static String folder_posts = "posts";
  static String folder_feeds = "feeds";
  static String folder_following = "following";
  static String folder_followers = "followers";

  /// Member Related
  static Future storeMember(Member member) async {
    member.uid = AuthService.currentUserId();

    return _firestore
        .collection(folder_users)
        .doc(member.uid)
        .set(member.toJson());
  }

  static Future updateMember(Member member) async {
    String uid = AuthService.currentUserId();

    return _firestore.collection(folder_users).doc(uid).update(member.toJson());
  }

  static Future loadMember() async {
    String uid = AuthService.currentUserId();
    var value = await _firestore.collection(folder_users).doc(uid).get();
    Member member = Member.fromJson(value.data()!);

    var quaerySnapshot1 = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_following)
        .get();
    member.followers_count= quaerySnapshot1.size;

    var quaerySnapshot2 = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_followers)
        .get();
    member.following_count= quaerySnapshot2.size;

    return member;
  }

  static Future<List<Member>> searchMembers(String keyword) async {
    List<Member> members = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await _firestore
        .collection(folder_users)
        .orderBy('email')
        .startAt([keyword]).get();
    LogService.i(querySnapshot.docs.length.toString());

    for (var result in querySnapshot.docs) {
      Member newMember = Member.fromJson(result.data());
      if (uid != newMember.uid) {
        members.add(newMember);
      }
    }
    return members;
  }

  static Future<Member> followMember(Member someone) async {
    Member me = await loadMember();

    // I followed tosomeone

    await _firestore
        .collection(folder_users)
        .doc(me.uid)
        .collection(folder_following)
        .doc(someone.uid)
        .set(someone.toJson());
    // I am in someone's followers

    await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_followers)
        .doc(me.uid)
        .set(me.toJson());

    return someone;
  }

  static Future<Member> unFollowMember(Member someone) async {
    Member me = await loadMember();

    // I un followed tosomeone

    await _firestore
        .collection(folder_users)
        .doc(me.uid)
        .collection(folder_following)
        .doc(someone.uid)
        .delete();
    // I am not in someone's followers

    await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_followers)
        .doc(me.uid)
        .delete();

    return someone;
  }

  /// Post Related
  static Future<Post> storePost(Post post) async {
    Member member = await loadMember();
    post.uid = member.uid;
    post.fullname = member.fullname;
    post.img_user = member.img_url;
    post.date = UtilsService.currentDate();

    String postId = _firestore
        .collection(folder_users)
        .doc(member.uid)
        .collection(folder_posts)
        .doc()
        .id;

    post.id = postId;

    await _firestore
        .collection(folder_users)
        .doc(member.uid)
        .collection(folder_posts)
        .doc(postId)
        .set(post.toJson());

    LogService.i("postId: ${postId}");

    return post;
  }

  /// post feed
  static Future<Post> storeFeed(Post post) async {
    String uid = AuthService.currentUserId();

    await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .get();
    for (var result in querySnapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      posts.add(post);
    }
    return posts;
  }

  /// load posts
  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_posts)
        .get();
    for (var result in querySnapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      posts.add(post);
    }
    return posts;
  }

  /// load likes
  static Future<List<Post>> loadLikes() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .where("liked", isEqualTo: true)
        .get();
    for (var result in querySnapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      posts.add(post);
    }
    return posts;
  }

  static Future likePost(Post post, bool liked) async {
    String uid = AuthService.currentUserId();
    post.liked = liked;

    await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());

    if (uid == post.uid) {
      await _firestore
          .collection(folder_users)
          .doc(uid)
          .collection(folder_posts)
          .doc(post.id)
          .set(post.toJson());
    }
  }

  static Future storePostsToMyFeed(Member someone) async {
    List<Post> posts = [];

    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_posts)
        .get();

    for (var result in querySnapshot.docs) {
      var post = Post.fromJson(result.data());
      post.liked = false;
      posts.add(post);
    }

    for (Post post in posts) {
      storeFeed(post);
    }
  }

  static Future removePostsToMyFeed(Member someone) async {
    List<Post> posts = [];

    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_posts)
        .get();

    for (var result in querySnapshot.docs) {
      var post = Post.fromJson(result.data());
      post.liked = false;
      posts.add(post);
    }

    for (Post post in posts) {
      removeFeed(post);
    }
  }

  static Future removeFeed(Post post) async {
    String uid = AuthService.currentUserId();

    return await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .delete();
  }

  static Future removePosts(Post post) async {
    String uid = AuthService.currentUserId();

    await removeFeed(post);
    return await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_posts)
        .doc(post.id)
        .delete();
  }
}
