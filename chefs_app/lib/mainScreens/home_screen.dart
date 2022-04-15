import 'package:chefs_app/authentication/auth_screen.dart';
import 'package:chefs_app/global/global.dart';
import 'package:chefs_app/model/menus.dart';
import 'package:chefs_app/splashScreen/splash_screen.dart';
import 'package:chefs_app/uploadScreens/menu_upload.dart';
import 'package:chefs_app/widgets/app_drawer.dart';
import 'package:chefs_app/widgets/info_design.dart';
import 'package:chefs_app/widgets/progress_bar.dart';
import 'package:chefs_app/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{

  restrictBlockedUsersFromUsingApp() async
  {
    await FirebaseFirestore.instance.collection("chef")
        .doc(firebaseAuth.currentUser!.uid)
        .get().then((snapshot)
    {
      if (snapshot.data()!["status"] != "approved")
      {
        Fluttertoast.showToast(msg: "This account has been blocked, please contact the Admin");

        firebaseAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c) => SplashScreen()));
      }
    });
  }


  @override
  void initState() {
    super.initState();

    restrictBlockedUsersFromUsingApp();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.post_add, color: Colors.white,),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c) => MenusUploadScreen()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("chef")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus").orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData ? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),)
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Menus model = Menus.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return InfoDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
