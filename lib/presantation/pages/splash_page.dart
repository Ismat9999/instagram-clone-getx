import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/presantation/controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var splashController= Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    splashController.initTimer();
    splashController.initNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(193,53,132,1),
              Color.fromRGBO(131,58,180,1),
            ]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text("Instagram",style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: "Billabong"),),
              ),
            ),
            Text("All rights reserved", style: TextStyle(color:Colors.white,fontSize: 16),),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
