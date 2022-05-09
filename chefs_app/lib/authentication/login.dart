import 'package:chefs_app/authentication/auth_screen.dart';
import 'package:chefs_app/global/global.dart';
import 'package:chefs_app/mainScreens/home_screen.dart';
import 'package:chefs_app/widgets/custom_text_field.dart';
import 'package:chefs_app/widgets/error_dialog.dart';
import 'package:chefs_app/widgets/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
    {
      //login
      loginNow();
    }
    else
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Please write email/password.",
            );
          }
      );
    }
  }


  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return LoadingDialog(
            message: "Checking Credentials",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Invalid Credentials",
            );
          }
      );
    });
    if(currentUser != null)
    {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("chef")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
          if (snapshot.exists)
          {
            if(snapshot.data()!["status"] == "approved")
              {
                await sharedPreferences!.setString("uid", currentUser.uid);
                await sharedPreferences!.setString("email", snapshot.data()!["chefEmail"]);
                await sharedPreferences!.setString("name", snapshot.data()!["chefName"]);
                await sharedPreferences!.setString("photoUrl", snapshot.data()!["chefAvatarUrl"]);

                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
              }
            else
              {
                firebaseAuth.signOut();
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "This account has been blocked, please contact the Admin");
            }

          }
          else
            {
              firebaseAuth.signOut();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
              showDialog(
                  context: context,
                  builder: (c)
                  {
                    return ErrorDialog(
                      message: "Invalid Credentials",
                    );
                  }
              );
            }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                "images/logo.png",
                height: 200,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
            onPressed: ()
            {
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
