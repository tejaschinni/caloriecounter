import 'package:caloriecounter/caloriescounter/viewRecipesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRegister extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  UserRegister({this.gUser, this.signOut});
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String documentPath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      documentPath = '/ShopOwner/${widget.gUser.email.toString()}';
    });
    isUserRegister();
    print('User Mail ID' + documentPath.toString());
  }

  void isUserRegister() {
    if (documentPath != null) {
      print('User is register' + documentPath.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewRecipesPage(
                    gUser: widget.gUser,
                    signOut: widget.signOut,
                  )));
    } else {
      print('User is not Register ' + documentPath.toString());
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => UserSignUp(
      //               gUser: widget.gUser,
      //               signOut: widget.signOut,
      //             )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: RaisedButton(
              child: Text('Sign Out'),
              onPressed: () {
                widget.signOut();
              }),
        ),
      ),
    );
  }
}
