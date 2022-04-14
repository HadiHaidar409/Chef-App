import 'package:chefs_app/authentication/auth_screen.dart';
import 'package:chefs_app/global/global.dart';
import 'package:chefs_app/mainScreens/earnings_screen.dart';
import 'package:chefs_app/mainScreens/history_screen.dart';
import 'package:chefs_app/mainScreens/home_screen.dart';
import 'package:chefs_app/mainScreens/new_orders_screen.dart';
import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
 {
    return Drawer(
      child: ListView(
        children: [
          //header container
          Container(
            padding: const EdgeInsets.only(top:25, bottom: 10),
            child: Column(
              children: [
                Material(
                 borderRadius: const BorderRadius.all(Radius.circular(80)),
                 elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                        sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                    sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Train"),
                )
              ],
            ),
          ),

          const SizedBox(height: 12,),

          //body container
          Container(
            padding: EdgeInsets.only(top: 1.0),
            child: Column(
            children: [
              Divider(
                height: 10,
                  color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.black,),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                  },
              ),
              ListTile(
                leading: Icon(Icons.monetization_on, color: Colors.black,),
                title: Text(
                  "Earnings",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>  EarningsScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.reorder, color: Colors.black,),
                title: Text(
                  "New Orders",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>  NewOrdersScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.local_shipping, color: Colors.black,),
                title: Text(
                  "Orders History",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.black,),
                title: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: ()
                {
                  firebaseAuth.signOut().then((value)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                  });
                },
              ),
            ],
            ),
          ),
        ],
      ),
    );
 }

}
