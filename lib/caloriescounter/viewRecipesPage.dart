import 'package:caloriecounter/caloriescounter/addRecipesPage.dart';
import 'package:caloriecounter/caloriescounter/signInDemo.dart';
import 'package:caloriecounter/caloriescounter/userDetailPage.dart';
import 'package:caloriecounter/data/totalCalData.dart';
import 'package:caloriecounter/data/userData.dart';
import 'package:caloriecounter/demo/nutritionPerDay.dart';
import 'package:caloriecounter/demo/flutterDateTimeDemo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ViewRecipesPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  ViewRecipesPage({
    this.signOut,
    this.gUser,
  });

  @override
  _ViewRecipesPageState createState() => _ViewRecipesPageState();
}

class _ViewRecipesPageState extends State<ViewRecipesPage> {
  int val, tprot = 0, tcal = 0, tcab = 0, tfat = 0, tgram = 0;
  DateTime _selectedDate, startedDate;
  String date;
  bool flag = false;
  UserData userData;
  TotalCalData totalCalData;
  var total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      startedDate = _selectedDate;
      print(_selectedDate);
    });
    //totalCal();

    //print('Totaol Calories' + totalCalData.tcalories.toString());
    getUserDate();
    fetchData();
    getcalDate();
    totaldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print(MediaQuery.of(context).size.width);
          print('--------sss-----------' + _selectedDate.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddRecipesPage(
                        gUser: widget.gUser,
                        signOut: widget.signOut,
                        selectedDate: _selectedDate,
                        userData: userData,
                      )));
        },
      ),
      appBar: AppBar(
        title: Text('View'),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            width: 35.0,
            height: 70.0,
            decoration: BoxDecoration(
              //color: const Color(0xff7c94b6),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: Container(
              child: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Profile',
                    child: ListTile(
                      leading: Icon(Icons.visibility),
                      title: Text('Proflie'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'SignOut',
                    child: ListTile(
                      leading: Icon(Icons.person_add),
                      title: Text('SignOut'),
                    ),
                  ),
                ],
                onSelected: (String s) {
                  print(s);
                  if (s == 'SignOut') {
                    widget.signOut();

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInDemo()));
                  }
                  if (s == 'Profile') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailPage(
                                  gUser: widget.gUser,
                                  selectedDate: _selectedDate,
                                  signOut: widget.signOut,
                                  userData: userData,
                                )));
                  }
                },
              ),
            ),
          ),
        ],
      ),
      // body: Container(
      //   child: DateScrollDemo(
      //     setDateTime: setDateTime,
      //   ),
      // ),
      body: DelayedDisplay(
        delay: Duration(seconds: 1),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('caloriecounter')
              .doc(widget.gUser.email)
              .collection('food')
              .doc(_selectedDate.toString())
              .collection('meals')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var food;

            try {
              food = snapshot.data.docs;

              //calc(food, food.length);

              setState(() {
                flag = false;
              });
            } catch (e) {
              print("NO DATA");
            }
            return flag
                ? Container()
                : Column(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: NutritionPerDay(
                          gUser: widget.gUser,
                          selectedDate: _selectedDate,
                          userData: userData,
                        ),
                      )),
                      Expanded(
                          child: Container(
                        child: FlutterDateTimeDemo(
                          setDateTime: setDateTime,
                          userData: userData,
                          // startedDate: startedDate,
                        ),
                      )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: food.length == 0
                                ? Container(
                                    child: Center(child: Text('NO DATA Found')))
                                : ListView.builder(
                                    itemCount: food.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.2,
                                                color: Colors.grey[300])),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    padding: EdgeInsets.all(12),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: food[index]
                                                                ['name']
                                                            .toString(),
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: '\n ' +
                                                                  food[index][
                                                                          'grams']
                                                                      .toString() +
                                                                  ' g',
                                                              style:
                                                                  TextStyle()),
                                                        ],
                                                      ),
                                                    ))),
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding: EdgeInsets.all(12),
                                                child: RichText(
                                                  textAlign: TextAlign.right,
                                                  text: TextSpan(
                                                    text: food[index]
                                                            ['calories']
                                                        .toString(),
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\nC: ' +
                                                              food[index]
                                                                      ['carbon']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey)),
                                                      TextSpan(
                                                          text: '\t F: ' +
                                                              food[index]
                                                                      ['fats']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .orange)),
                                                      TextSpan(
                                                          text: '\t P: ' +
                                                              food[index][
                                                                      'protiens']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.red))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                          )),
                    ],
                  );
          },
        ),
      ),
    );
  }

  void calc(food, l) async {
    //print("____________________________" + food[1]['carbon'].toString());
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
  }

  void getcalDate() async {
    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .collection('food')
        .doc(_selectedDate.toString())
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
        .collection('food')
        .doc(_selectedDate.toString())
        .get()
        .then((DocumentSnapshot ds) => {
              setState(() {
                ds.data();
                totalCalData = TotalCalData.fromSnapshot(ds);
              }),
              print('Total Cal' + totalCalData.tcalories.toString()),
            });
  }

  void setDateTime(DateTime _selectedValue) {
    setState(() {
      this._selectedDate = _selectedValue;
    });

    print('--------sss-----------' + _selectedDate.toString());
  }

  void getUserDate() async {
    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
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
                userData = UserData.fromSnapshot(ds);
                startedDate = userData.date.toDate();
              }),
              print('User Name' + userData.date.toDate().toString()),
            });
  }

  fetchData() async {
    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .collection('food')
        .doc(_selectedDate.toString())
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
              }),
              print('Carbs total' + tcab.toString()),
              print('cal total' + tcal.toString()),
              print('fat total' + tfat.toString()),
              print('protien total' + tprot.toString()),
              FirebaseFirestore.instance
                  .collection('caloriecounter')
                  .doc(widget.gUser.email)
                  .collection('food')
                  .doc(_selectedDate.toString())
                  .set({
                'tcalories': tcal,
                'tcrabs': tcab,
                'tfat': tfat,
                'tprotiens': tprot,
                'tgram': tgram
              }),
            });
  }

  void totaldata() {}
}
