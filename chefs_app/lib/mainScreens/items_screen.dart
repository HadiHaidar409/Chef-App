import 'package:chefs_app/global/global.dart';
import 'package:chefs_app/model/items.dart';
import 'package:chefs_app/model/menus.dart';
import 'package:chefs_app/uploadScreens/items_upload.dart';
import 'package:chefs_app/widgets/items_design.dart';
import 'package:chefs_app/widgets/progress_bar.dart';
import 'package:chefs_app/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class ItemsScreen extends StatefulWidget
{

  final Menus? model;
  ItemsScreen({this.model});


  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.library_add, color: Colors.cyan,),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsUploadScreen(model: widget.model)));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My " + widget.model!.menuTitle.toString() + "'s Items")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("chef")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items").orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return ItemsDesignWidget(
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
