import 'package:caloriecounter/data/totalCalData.dart';
import 'package:caloriecounter/data/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NutritionPerDay extends StatefulWidget {
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  UserData userData;
  NutritionPerDay({this.gUser, this.selectedDate, this.userData});

  @override
  _NutritionPerDayState createState() => _NutritionPerDayState();
}

class _NutritionPerDayState extends State<NutritionPerDay> {
  bool flag = false;
  TotalCalData totalCalData;
  int tcab, tcal, tfat, tgram, tprot;
  DocumentReference documentReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTotalData();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('caloriecounter')
            .doc(widget.gUser.email)
            .collection('food')
            .doc(widget.selectedDate.toString())
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var food;

          try {
            food = snapshot.data.data();

            //calc(food, food.length);

            setState(() {
              flag = false;
            });
          } catch (e) {
            print("NO DATA");
          }
          return flag
              ? Container()
              : Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Center(
                    child: food == null
                        ? Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Calories',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Carbs',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Fat',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Protiens',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tcalories'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Calories',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tcrabs'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Carbs',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tfat'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Fat',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tprotiens'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Protiens',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ),
                );
        },
      ),
    ));
  }

  void getTotalData() async {
    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(documentSnapshot.reference);
      }
    });

    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .get()
        .then((DocumentSnapshot ds) => {
              setState(() {
                ds.data();
                totalCalData = TotalCalData.fromSnapshot(ds);
              }),
              print(' NutritionPerDay Total Calories ' +
                  totalCalData.tcalories.toString()),
            });
  }

  fetchData() async {
    documentReference = FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString());
    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString())
        .collection('meals')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                tcab = 0;
                tcal = 0;
                tfat = 0;
                tgram = 0;
                tprot = 0;
                for (var item in querySnapshot.docs) {
                  tcab = tcab + item['carbon'];
                  tcal = tcal + item['calories'];
                  tfat = tfat + item['fats'];
                  tprot = tprot + item['protiens'];
                  tgram = tgram + item['grams'];
                }
                tcab = doc['carbon'];
                tcal = doc['calories'];
                tfat = doc['fats'];
                tprot = doc['protiens'];
                tgram = doc['grams'];
              }),
              print('Carbs total' + tcab.toString()),
              print('cal total' + tcal.toString()),
              print('fat total' + tfat.toString()),
              print('protien total' + tprot.toString()),
            });
    print('NutritionPerDay Document ID' + documentReference.id);
  }
}
