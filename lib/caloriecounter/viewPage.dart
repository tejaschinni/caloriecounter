import 'package:caloriecounter/caloriecounter/addFood.dart';
import 'package:caloriecounter/caloriecounter/addFromRecipe.dart';
import 'package:caloriecounter/caloriecounter/addRecipePage.dart';
import 'package:caloriecounter/caloriecounter/nutritionPerDay.dart';
import 'package:caloriecounter/caloriecounter/userRegisterPage.dart';
import 'package:caloriecounter/caloriecounter/viewRecipePage.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:caloriecounter/demo/flutterTimedatePicker.dart';
import 'package:caloriecounter/demo/listbiewSearchPage.dart';
import 'package:caloriecounter/demo/searchDemo.dart';
import 'package:caloriecounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ViewPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;

  ViewPage(this.gUser, this.signOut);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isWorking = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Recipies> userRecipieList = [];

  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool flag = false;
  Timestamp startTimestamp = Timestamp.now();
  DateTime startDateTime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // print('Date ' + startDateTime.toString());
    _read();
    _readUserRecipeList();
    _readUser();
  }

  void _readUserRecipeList() async {
    firestore
        .collection("caloriecounter")
        .doc(widget.gUser.email)
        .collection('recipes')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          int cal =
              int.parse((result.data() as dynamic)['calories'].toString());
          int carb = int.parse((result.data() as dynamic)['carbon'].toString());
          int fat = int.parse((result.data() as dynamic)['fats'].toString());
          int gram = int.parse((result.data() as dynamic)['grams'].toString());
          int pro =
              int.parse((result.data() as dynamic)['protiens'].toString());
          print(cal);
          Recipies r = Recipies(cal, carb, fat, gram,
              (result.data() as dynamic)['name'], pro, result.reference);
          userRecipieList.add(r);
        });
      });
    });
  }

  void _readUser() {
    FirebaseFirestore.instance
        .collection("caloriecounter")
        .doc(widget.gUser.email.toString())
        .get()
        .then((value) {
      if (value.data() == null) {
        setState(() {
          isWorking = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) =>
                    UserRegisterPage(widget.gUser, widget.signOut)));
      }
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .collection('food')
        .doc(_selectedDate.toString())
        .collection('meals')
        .snapshots();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {});
    _refreshController.loadComplete();
  }

  void _read() async {
    //print(' My email  = ' + widget.gUser.email.toString());
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .get();
      setState(() {
        startTimestamp = (documentSnapshot.data() as dynamic)['date'];
        startDateTime = DateTime.fromMicrosecondsSinceEpoch(
            startTimestamp.microsecondsSinceEpoch);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddFoodFromRecipie(widget.gUser,
                          _selectedDate, widget.signOut, userRecipieList)));
            });
          },
        ),
        appBar: AppBar(
          title: Text('View Data'),
          actions: [
            Center(
              child: Container(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  child: Icon(Icons.person),
                  onTap: () {
                    widget.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (contex) => SigInPage()));
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  child: Icon(Icons.smart_display),
                  onTap: () {
                    print(userRecipieList);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (contex) => ListViewSearchBar(
                    //             widget.gUser,
                    //             widget.signOut,
                    //             userRecipieList,
                    //             _selectedDate)));
                  },
                ),
              ),
            )
          ],
        ),
        body:
            // isWorking
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
            DelayedDisplay(
                delay: Duration(seconds: 1),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('caloriecounter')
                      .doc(widget.gUser.email)
                      .collection('food')
                      .doc(_selectedDate.toString())
                      .collection('meals')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var food;

                    try {
                      food = snapshot.data!.docs;

                      setState(() {
                        flag = false;
                      });
                    } catch (e) {
                      print("NO DATA");
                    }
                    if (flag) {
                      return Container();
                    } else {
                      return Column(
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(10),
                            child: NutritionPerDay(widget.gUser, _selectedDate),
                          )),
                          Expanded(
                              child: Container(
                                  child: FlutterDateTimeDemo(
                                      startDateTime, setDateTime))),
                          Expanded(
                              flex: 4,
                              child: SmartRefresher(
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                onLoading: _onLoading,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: food.length == 0
                                      ? Container(
                                          child: Center(
                                              child: Text('NO DATA Found')))
                                      : ListView.builder(
                                          itemCount: food.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.2,
                                                      color: Colors.grey)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              text: food[index]
                                                                      ['name']
                                                                  .toString(),
                                                              style: DefaultTextStyle
                                                                      .of(context)
                                                                  .style,
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text: '\n ' +
                                                                        food[index]['grams']
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
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.right,
                                                        text: TextSpan(
                                                          text: food[index]
                                                                  ['calories']
                                                              .toString(),
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: '\nC: ' +
                                                                    food[index][
                                                                            'carbon']
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey)),
                                                            TextSpan(
                                                                text: '\t F: ' +
                                                                    food[index][
                                                                            'fats']
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .orange)),
                                                            TextSpan(
                                                                text: '\t P: ' +
                                                                    food[index][
                                                                            'protiens']
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .red))
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
                              )),
                        ],
                      );
                    }
                  },
                )));
  }

  void setDateTime(DateTime _selectedValue) {
    setState(() {
      this._selectedDate = DateTime(
          _selectedValue.year, _selectedValue.month, _selectedValue.day);
    });

    print('--------sss-----------' + _selectedDate.toString());
  }
}
