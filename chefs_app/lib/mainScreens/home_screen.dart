import 'package:chefs_app/authentication/auth_screen.dart';
import 'package:chefs_app/global/global.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Logout"),
          style: ElevatedButton.styleFrom(),
          onPressed: ()
          {
            firebaseAuth.signOut().then((value)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
            });
          },
        ),
      ),
    );
  }
}
