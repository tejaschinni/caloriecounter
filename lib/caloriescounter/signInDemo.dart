// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:caloriecounter/caloriescounter/addRecipesPage.dart';
import 'package:caloriecounter/caloriescounter/constant.dart';
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
  // FirebaseUser user;
  String _contactText;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser == null) {
        _handleSignIn();
      }
    });
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

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    if (_currentUser != null) {
      return AddRecipesPage(
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

// import 'dart:async';

// import 'package:caloriescounter/caloriescounter/addRecipesPage.dart';
// import 'package:caloriescounter/caloriescounter/constant.dart';
// import 'package:delayed_display/delayed_display.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// // NOTE: to add firebase support, first go to firebase console, generate the
// // firebase json file, and add configuration lines in the gradle files.
// // C.f. this commit: https://github.com/X-Wei/flutter_catalog/commit/48792cbc0de62fc47e0e9ba2cd3718117f4d73d1.
// class AuthPage extends StatefulWidget {
//   const AuthPage({Key key}) : super(key: key);

//   @override
//   _AuthPageState createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   FirebaseUser _user;
//   bool status = false;
//   // If this._busy=true, the buttons are not clickable. This is to avoid
//   // clicking buttons while a previous onTap function is not finished.
//   bool _busy = false, processing = false, validSakUser = false;
//   String msg = 'Signing in with google';

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       processing = true;
//       signOut();
//       processing = false;
//     });
//   }

//   // Future<void> getProfileStatus() async {
//   //   Firestore.instance
//   //       .collection('maintain')
//   //       .document(_user.email)
//   //       .get()
//   //       .then((DocumentSnapshot ds) {
//   //     setState(() {
//   //       status = ds['active'];
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final avatar = CircleAvatar(
//         backgroundImage: NetworkImage(
//             _user != null
//                 ? _user.photoUrl
//                 : 'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png',
//             scale: 1.0));

//     final googleLoginBtn = _user != null
//         ? SizedBox()
//         : Column(
//             children: <Widget>[
//               Text(
//                 'Login With Google',
//                 style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               MaterialButton(
//                 animationDuration: Duration(milliseconds: 500),
//                 hoverElevation: 11,
//                 color: Colors.grey[200],
//                 elevation: 5,
//                 child: ListTile(
//                   leading: Icon(
//                     Icons.access_alarm,
//                     color: Colors.red,
//                   ),
//                   title: Text(
//                     'Log in with Google',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 onPressed: this._busy
//                     ? null
//                     : () async {
//                         if (_user == null) {
//                           setState(() {
//                             this._busy = true;
//                             this.processing = true;
//                           });
//                           final user = await this._googleSignIn();
//                           setState(() {
//                             this._busy = false;
//                           });

//                           //isSakRegisteredAccount();
//                         } else {
//                           print('already user present');
//                         }
//                       },
//               ),
//             ],
//           );

//     final gap = SizedBox(height: 20);

//     final yourProfile = _user != null && status
//         ? MaterialButton(
//             color: Colors.cyan[50],
//             elevation: 5,
//             child: ListTile(
//               leading: avatar,
//               title: Text(
//                 'Click to Continue',
//                 style: TextStyle(color: Colors.black, fontSize: 14),
//               ),
//               trailing: Icon(Icons.navigate_next),
//             ),
//             onPressed: () async {
//               setState(() {
//                 processing = true;
//                 msg = 'Going to Dashboard';
//               });
//               Timer(const Duration(seconds: 2), () {
//                 setState(() {
//                   processing = true;
//                 });

//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => AddRecipesPage()));
//               });
//             },
//           )
//         : SizedBox();

//     return _user == null
//         ? Scaffold(
//             body: SafeArea(
//             child: Stack(
//               children: <Widget>[
//                 Container(),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     DelayedDisplay(
//                       delay: Duration(seconds: 1),
//                       child: Container(
//                         margin: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height / 10),
//                         height: MediaQuery.of(context).size.height / 2.1,
//                         // child: Image.asset('assets/slider0.png'),
//                       ),
//                     ),
//                     processing
//                         ? Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(top: 20),
//                                 child: Text(
//                                   msg,
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.black38,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Container(
//                             margin: EdgeInsets.only(left: 60, right: 60),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 DelayedDisplay(
//                                     delay: Duration(milliseconds: 500),
//                                     child: yourProfile),
//                                 googleLoginBtn,
//                                 gap,
//                               ],
//                             ),
//                           ),
//                   ],
//                 ),
//               ],
//             ),
//           ))
//         : AddRecipesPage();
//   }

//   // Sign in with Google.
//   Future<FirebaseUser> _googleSignIn() async {
//     final curUser = this._user ?? await FirebaseAuth.instance.currentUser();
//     if (curUser != null && !curUser.isAnonymous) {
//       return curUser;
//     }
//     final googleUser = await GoogleSignIn().signIn();
//     final googleAuth = await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
//     final user =
//         (await FirebaseAuth.instance.signInWithCredential(credential)).user;

//     setState(() => this._user = user);

//     return user;
//   }

//   Future<Null> signOut() async {
//     setState(() {
//       validSakUser = false;
//     });
//     FirebaseAuth.instance.signOut();
//     await cGoogleSignIn.signOut();
//     setState(() => this._user = null);
//   }
// }
