import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/assistantMethods/assistant_methods.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/widgets/app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemDetailsScreen extends StatefulWidget
{
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
{
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: MyAppBar(chefUID: widget.model!.chefUID),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(widget.model!.thumbnailUrl.toString(),
              height: 250, width: MediaQuery.of(context).size.width,),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: NumberInputPrefabbed.roundedButtons(
              controller: counterTextEditingController,
              incDecBgColor: Colors.amber,
              min: 1,
              max: 9,
              initialValue: 1,
              buttonArrangement: ButtonArrangement.incRightDecLeft,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text( "£ "+
              widget.model!.price.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          SizedBox(height: 10,),

          Center(
            child: InkWell(
              onTap: ()
              {
                int itemCounter = int.parse(counterTextEditingController.text);

                List<String> separateItemIDsList = separateItemIDs();

                //1.check if item exist already in cart
                separateItemIDsList.contains(widget.model!.itemID)
                    ? Fluttertoast.showToast(msg: "Item is already in Cart.")
                    :
                //2.add to cart
                addItemToCart(widget.model!.itemID, context, itemCounter);
              },
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                child: Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
