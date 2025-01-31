import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/presantation/controllers/my_search_controller.dart';

import '../widgets/items/item_of_member.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchController = Get.find<MySearchController>();

  @override
  void initState() {
    super.initState();
    searchController.apiLoadMembers("");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Search"),
      ),
      body: GetBuilder<MySearchController>(
        builder: (_) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    //   #search member
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(7)),
                      child: TextField(
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.grey),
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  //   #member_list
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchController.items.length,
                        itemBuilder: (context, index){
                          return itemOfMember(searchController.items[index],searchController,context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              searchController.isLoading ? Center(
                child: CircularProgressIndicator(),
              ): SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
