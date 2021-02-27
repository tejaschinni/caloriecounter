import 'package:caloriecounter/caloriescounter/addRecipesPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ViewRecipesPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  ViewRecipesPage({this.signOut, this.gUser});

  @override
  _ViewRecipesPageState createState() => _ViewRecipesPageState();
}

class _ViewRecipesPageState extends State<ViewRecipesPage> {
  int val, tprot = 0, tcal = 0, tcab = 0, tfat = 0, tgram = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(MediaQuery.of(context).size.width);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddRecipesPage(
                        gUser: widget.gUser,
                        signOut: widget.signOut,
                      )));
        },
      ),
      appBar: AppBar(
        title: Text('View'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fooder')
            .doc(widget.gUser.email)
            .collection('food')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final food = snapshot.data.docs;
          calc(food, food.length);
          return food.length == 0
              ? Container()
              : Column(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.redAccent,
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.08,
                                      child: Text(
                                        tcal.toString(),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Container(
                                  //   child: Text('Calories',
                                  //       style: TextStyle(
                                  //           fontSize: 12, color: Colors.black)),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.08,
                                      backgroundColor: Colors.grey,
                                      child: Text(tcab.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Container(
                                  //   child: Text('Carbs',
                                  //       style: TextStyle(
                                  //           fontSize: 12, color: Colors.black)),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.08,
                                      backgroundColor: Colors.orange,
                                      child: Text(tfat.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Container(
                                  //   child: Text('Fat',
                                  //       style: TextStyle(
                                  //           fontSize: 12, color: Colors.black)),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.08,
                                      child: Text(tprot.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Container(
                                  //   child: Text('Protiens',
                                  //       style: TextStyle(
                                  //           fontSize: 12, color: Colors.black)),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                      flex: 4,
                      child: ListView.builder(
                          itemCount: food.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.2, color: Colors.grey[300])),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          padding: EdgeInsets.all(12),
                                          child: RichText(
                                            text: TextSpan(
                                              text: food[index]['name']
                                                  .toString(),
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '\n ' +
                                                        food[index]['grams']
                                                            .toString() +
                                                        ' g',
                                                    style: TextStyle()),
                                              ],
                                            ),
                                          ))),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.all(12),
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(
                                          text: food[index]['calories']
                                              .toString(),
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '\nC: ' +
                                                    food[index]['carbon']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                            TextSpan(
                                                text: '\t F: ' +
                                                    food[index]['fats']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.orange)),
                                            TextSpan(
                                                text: '\t P: ' +
                                                    food[index]['protiens']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void calc(food, l) {
    print("____________________________" + food[1]['carbon'].toString());
    tcab = 0;
    tcal = 0;
    tfat = 0;
    tgram = 0;
    tprot = 0;
    for (var item in food) {
      tcab = tcab + item['carbon'];
      tcal = tcal + item['calories'];
      tfat = tfat + item['fats'];
      tprot = tprot + item['protiens'];
      tgram = tgram + item['grams'];
    }
    print('-------------------' + tcab.toString());
  }
}
