// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:delayed_display/delayed_display.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class Demo extends StatefulWidget {
//   Function signOut;
//   GoogleSignInAccount gUser;
//   Demo(this.gUser, this.signOut);

//   @override
//   _DemoState createState() => _DemoState();
// }

// class _DemoState extends State<Demo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Demo Page For to get Document Refrences '),
//       ),
//       body: DelayedDisplay(
//           delay: Duration(seconds: 1),
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('caloriecounter')
//                 .doc(widget.gUser.email)
//                 .collection('recipes')
//                 .snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               print(snapshot.data);
//               var recipes;

//               try {
//                 recipes = snapshot.data!.docs;

//                 setState(() {
//                   flag = false;
//                 });
//               } catch (e) {
//                 print("NO DATA");
//               }
//               if (flag) {
//                 return Container();
//               } else {
//                 return Column(
//                   children: [
//                     Expanded(
//                         flex: 4,
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           child: recipes.length == 0
//                               ? Container(
//                                   child: Center(child: Text('NO DATA Found')))
//                               : ListView.builder(
//                                   itemCount: recipes.length,
//                                   itemBuilder: (context, index) {
//                                     return InkWell(
//                                       child: Container(
//                                         padding: EdgeInsets.all(2),
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 width: 0.2,
//                                                 color: Colors.grey)),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                                 flex: 2,
//                                                 child: Container(
//                                                     padding: EdgeInsets.all(12),
//                                                     child: RichText(
//                                                       text: TextSpan(
//                                                         text: recipes[index]
//                                                                 ['name']
//                                                             .toString(),
//                                                         style:
//                                                             DefaultTextStyle.of(
//                                                                     context)
//                                                                 .style,
//                                                         children: <TextSpan>[
//                                                           TextSpan(
//                                                               text: '\n ' +
//                                                                   recipes[index]
//                                                                           [
//                                                                           'grams']
//                                                                       .toString() +
//                                                                   ' g',
//                                                               style:
//                                                                   TextStyle()),
//                                                         ],
//                                                       ),
//                                                     ))),
//                                             Expanded(
//                                               child: Container(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 padding: EdgeInsets.all(12),
//                                                 child: RichText(
//                                                   textAlign: TextAlign.right,
//                                                   text: TextSpan(
//                                                     text: recipes[index]
//                                                             ['calories']
//                                                         .toString(),
//                                                     style: DefaultTextStyle.of(
//                                                             context)
//                                                         .style,
//                                                     children: <TextSpan>[
//                                                       TextSpan(
//                                                           text: '\nC: ' +
//                                                               recipes[index]
//                                                                       ['carbon']
//                                                                   .toString(),
//                                                           style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.grey)),
//                                                       TextSpan(
//                                                           text: '\t F: ' +
//                                                               recipes[index]
//                                                                       ['fats']
//                                                                   .toString(),
//                                                           style: TextStyle(
//                                                               fontSize: 12,
//                                                               color: Colors
//                                                                   .orange)),
//                                                       TextSpan(
//                                                           text: '\t P: ' +
//                                                               recipes[index][
//                                                                       'protiens']
//                                                                   .toString(),
//                                                           style: TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.red))
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         print(recipes[index]
//                                             .documentID
//                                             .toString());
//                                         // Navigator.push(
//                                         //     context,
//                                         //     MaterialPageRoute(
//                                         //         builder: (contex) =>
//                                         //             EditRecipePage(
//                                         //                 widget.gUser,
//                                         //                 widget.signOut,
//                                         //                 recipes[index])));
//                                       },
//                                     );
//                                   }),
//                         )),
//                   ],
//                 );
//               }
//             },
//           ))
//     );
//   }
// }

