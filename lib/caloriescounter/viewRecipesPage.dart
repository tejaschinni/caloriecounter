import 'package:caloriecounter/caloriescounter/addRecipesPage.dart';
import 'package:caloriecounter/caloriescounter/signInDemo.dart';
import 'package:caloriecounter/caloriescounter/userDetailPage.dart';
import 'package:caloriecounter/data/userData.dart';
import 'package:caloriecounter/demo/flutterDateTimeDemo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  DateTime _selectedDate;
  String date;
  bool flag = false;
  UserData userData;

  List<UserData> userD = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      print(_selectedDate);
      getUserDate();
    });
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('caloriecounter')
            .doc(widget.gUser.email)
            .collection('food')
            .doc(_selectedDate.toString())
            .collection('meals')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var food;
          try {
            food = snapshot.data.docs;
            calc(food, food.length);
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
                                  Container(
                                    child: Text('Calories',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  )
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
                                  Container(
                                    child: Text('Carbs',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  )
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
                                  Container(
                                    child: Text('Fat',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  )
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
                                  Container(
                                    child: Text('Protiens',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  )
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
                        child: Container(
                      child: FlutterDateTimeDemo(
                        setDateTime: setDateTime,
                      ),
                    )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: food.length == 0
                              ? Container(
                                  child: Center(
                                      child: CircularProgressIndicator()))
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
                                                      text: food[index]['name']
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
                                                            food[index]['fats']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.orange)),
                                                    TextSpan(
                                                        text: '\t P: ' +
                                                            food[index]
                                                                    ['protiens']
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
                        )),
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
    print('--------food---------' + food.length.toString());
  }

  void setDateTime(DateTime _selectedValue) {
    setState(() {
      this._selectedDate = _selectedValue;
    });
    //this._selectedDate = _selectedValue;

    print('--------sss-----------' + _selectedDate.toString());
  }

  void getUserDate() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('caloriecounter').get();

    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((data) {
      final user = UserData.fromSnapshot(data);
      userD.add(user);

      print('User name ' + userD.length.toString());
    });
  }
}
