import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/core/services/db_service.dart';
import 'package:instaclone/core/services/file_service.dart';
import 'package:instaclone/data/datasources/models/post_model.dart';

class MyUploadController extends GetxController {
  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? pickedImage;

  uploadNewPost(PageController pageController) async {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (pickedImage == null) return;

    isLoading = true;
    update();

    String img_post = await FileService.uploadPostImage(pickedImage!);
    Post post = Post(caption, img_post);
    Post mypost= await DBService.storePost(post);
    await DBService.storeFeed(mypost);

    isLoading = false;
    update();

    clearImageAndCaption(pageController);
  }

  clearImageAndCaption(PageController pageController) {
    captionController.text = "";
    removePickedImage();
    moveToFeedPage(pageController);
  }

  moveToFeedPage(PageController pageController) {
    pageController.animateToPage(0,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void imgFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      pickedImage = File(image.path);
    }
    update();
  }

  void imgFromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    pickedImage = File(image!.path);
    update();
  }

  removePickedImage() {
    pickedImage = null;
    update();
  }
}
