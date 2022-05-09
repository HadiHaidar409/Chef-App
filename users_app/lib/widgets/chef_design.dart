import 'package:flutter/material.dart';
import 'package:users_app/mainScreens/menus_screen.dart';
import 'package:users_app/models/chef.dart';


class ChefDesignWidget extends StatefulWidget {

  Chef? model;
  BuildContext? context;

  ChefDesignWidget({this.model, this.context});


  @override
  State<ChefDesignWidget> createState() => _ChefDesignWidgetState();
}

class _ChefDesignWidgetState extends State<ChefDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => MenusScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.chefAvatarUrl!,
                height: 220.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1.0,),
              Text(
                widget.model!.chefName!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 25,
                ),
              ),
              Text(
                widget.model!.chefEmail!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
