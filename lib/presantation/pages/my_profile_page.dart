import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/presantation/controllers/my_profile_controller.dart';

import '../widgets/items/item_of_profile.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  var profileController = Get.find<MyProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.addFewPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.exit_to_app,
              color: Color.fromRGBO(192, 53, 132, 1),
            ),
          ),
        ],
      ),
      body: GetBuilder<MyProfileController>(
        builder: (_) {
          return Column(
            children: [
              //# myphoto
              GestureDetector(
                // #myphoto
                onTap: () {},
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(
                          width: 1.5,
                          color: Color.fromRGBO(193, 53, 132, 1),
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: profileController.member_image == null ||
                                  profileController.member_image!.isEmpty
                              ? Image(
                                  image:
                                      AssetImage("assets/images/ic_person.png"),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  profileController.member_image!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //   #myinfo
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    profileController.member_fullname!,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(profileController.member_email!,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              //   #myaccount
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              profileController.count_posts.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "POST",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              profileController.count_follow.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "FOLLOWERS",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              profileController.count_following
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "FOLLOWING",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //   #list_or_grid
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            profileController.changedAxisCount(1);
                          },
                          icon: Icon(Icons.list_alt),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            profileController.changedAxisCount(2);
                          },
                          icon: Icon(Icons.grid_view),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // myposts
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: profileController.axisCount),
                  itemCount: profileController.items.length,
                  itemBuilder: (context, index) {
                    return itemOfProfile(
                        profileController.items[index], context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
