import 'package:get/get.dart';

import '../../data/datasources/models/member_model.dart';

class MySearchController extends GetxController {
  bool isLoading = false;
  List<Member> items = [];

  addFakeMembers() {
    Member member1 = Member("Ismatilla", "ismatilla@gmail.com");
    member1.img_url =
        "https://images.unsplash.com/photo-1737111869094-80ed40daca91?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    Member member2 = Member("Aziz", "aziz@gmail.com");

    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
  }
}
