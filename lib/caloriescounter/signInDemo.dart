// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:caloriecounter/caloriescounter/addRecipesPage.dart';
import 'package:caloriecounter/caloriescounter/constant.dart';
import 'package:caloriecounter/caloriescounter/userRegister.dart';
import 'package:caloriecounter/caloriescounter/viewRecipesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[],
);

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount _currentUser;
  String gUser;
  String documentPath;

  // FirebaseUser user;
  String _contactText;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
        gUser = account.displayName;
        print(
            '_________________________________User Email ' + gUser.toString());
      });

      if (_currentUser == null) {
        _handleSignIn();
      }
    });
    isUserRegister();
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }

    // final GoogleSignInAuthentication googleAuth =
    //     await _currentUser.authentication;
    // final AuthCredential credential = GoogleAuthProvider.getCredential(
    //     idToken: googleAuth.idToken, accessToken: null);
    // await cFireBaseAuth.signInWithCredentail(credential);
  }

  void signOut() {
    _handleSignOut();
  }

  void isUserRegister() {
    print('_________________________________User Email ' + gUser.toString());
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    if (_currentUser != null) {
      return ViewRecipesPage(
        gUser: _currentUser,
        signOut: signOut,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }
}
