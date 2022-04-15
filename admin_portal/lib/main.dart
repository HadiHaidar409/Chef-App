import 'package:admin_portal/auth/login_screen.dart';
import 'package:admin_portal/main_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 Future<void>main() async
{



  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Portal',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomeScreen(),
    );
  }
}

