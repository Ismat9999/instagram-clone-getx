import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:instaclone/presantation/pages/splash_page.dart';

import 'core/config/root_binding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDBAPP0QORa1EOnzndqQ9y0mCPzp9uvP3U',
      appId: '1:874665280513:android:57fb1c50557f2ed4ab6c00',
      messagingSenderId: '874665280513',
      projectId: 'instaclone-3-470b7',
      storageBucket: "instaclone-3-470b7.firebasestorage.app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      initialBinding: RootBinding(),
    );
  }
}
