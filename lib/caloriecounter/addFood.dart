import 'dart:ffi';

import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:caloriecounter/caloriecounter/viewRecipePage.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:caloriecounter/demo/listbiewSearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddFood extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Recipies> userRecipeList;

  AddFood(this.gUser, this.selectedDate, this.signOut, this.userRecipeList);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  bool validator = true;

  String name = ' ';
  int grams = 0,
      carbon = 0,
      fats = 0,
      protiens = 0,
      calories = 0,
      tcab = 0,
      tcal = 0,
      tfat = 0,
      tgram = 0,
      tprot = 0;

  int __gram = 0, __cal = 0, __carb = 0, __fat = 0, __prot = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void validate() {
    if (nameController.text.length > 2 &&
        gramsController.text.length > 0 &&
        protiensController.text.length > 0 &&
        carbonController.text.length > 0 &&
        caloriesController.text.length > 0 &&
        fatsController.text.length > 0) {
      setState(() {
        validator = true;
        print(' ---------------------------- Validation True ');
      });
    } else {
      setState(() {
        validator = false;
        print(' ---------------------------- Validation false ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Daily intake' + widget.selectedDate.toString()),
        //   actions: [
        //     Container(
        //       padding: EdgeInsets.all(10),
        //       child: InkWell(
        //         child: Icon(Icons.home),
        //         onTap: () {
        //           widget.signOut();
        //         },
        //       ),
        //     )
        //   ],
        // ),
        body: Container(
          child: Container(
            child: Column(
              children: [
                Expanded(
                    flex: 6,
                    child: Container(
                        child: ListViewSearchBar(
                            widget.gUser,
                            widget.signOut,
                            widget.userRecipeList,
                            widget.selectedDate,
                            setRecipeValue))),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text('Recipe Name : '),
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            nameController.text,
                                            style: TextStyle(fontSize: 18),
                                          ))),
                                  SizedBox(
                                    height: 40,
                                    width: 60,
                                    child: SizedBox(
                                      height: 40,
                                      width: 20,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: gramsController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (String val) {
                                          setState(() {
                                            __gram = int.parse(val);
                                          });
                                          validate();
                                          onGramchange();
                                        },
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Grams',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: setRecipeValue == 'null'
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
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
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
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
                                                  backgroundColor:
                                                      Colors.redAccent[700],
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
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
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
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
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  child: Text(
                                                    caloriesController.text,
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
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  child: Text(
                                                    carbonController.text,
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
                                                  backgroundColor:
                                                      Colors.yellowAccent,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  child: Text(
                                                    fatsController.text,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black),
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
                                                  backgroundColor:
                                                      Colors.redAccent[700],
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  child: Text(
                                                    protiensController.text,
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
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              validate();
              addFood();
              _read();

              nameController.text = "";
              protiensController.text = "";
              caloriesController.text = "";
              gramsController.text = "";
              fatsController.text = "";
              carbonController.text = "";
              name = "";
              fats = 0;
              grams = 0;
              protiens = 0;
              calories = 0;
              carbon = 0;

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewPage(widget.gUser, widget.signOut)));
            });
          },
        ));
  }

  Future<void> addFood() async {
    firestore
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString())
        .collection('meals')
        .doc()
        .set({
      'name': name,
      'fats': __fat,
      'grams': __gram,
      'protiens': __prot,
      'calories': __cal,
      'carbon': __carb
    });
  }

  void _read() async {
    try {
      FirebaseFirestore.instance
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .collection('food')
          .doc(widget.selectedDate.toString())
          .collection('meals')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          tcab = 0;
          tcal = 0;
          tfat = 0;
          tgram = 0;
          tprot = 0;
          for (var item in querySnapshot.docs) {
            tcab = tcab + int.parse(item['carbon'].toString());
            tcal = tcal + int.parse(item['calories'].toString());
            tfat = tfat + int.parse(item['fats'].toString());
            tprot = tprot + int.parse(item['protiens'].toString());
            tgram = tgram + int.parse(item['grams'].toString());
          }
        });
        firestore
            .doc(widget.gUser.email)
            .collection('food')
            .doc(widget.selectedDate.toString())
            .set({
          'tcalories': tcal,
          'tcrabs': tcab,
          'tfat': tfat,
          'tprotiens': tprot,
          'tgram': tgram
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void setRecipeValue(
      String name, int cal, int grm, int carb, int prot, int fat) {
    setState(() {
      this.grams = grm;
      this.calories = cal;
      this.carbon = carb;
      this.protiens = prot;
      this.fats = fat;
      this.name = name;

      __cal = int.parse(cal.toString());
      __gram = int.parse(grm.toString());
      __carb = int.parse(carb.toString());
      __fat = int.parse(fat.toString());
      __prot = int.parse(prot.toString());

      nameController.text = name;
      gramsController.text = __gram.toString();
      caloriesController.text = __cal.toString();
      carbonController.text = __carb.toString();
      fatsController.text = __fat.toString();
      protiensController.text = __prot.toString();
    });
  }

  void onGramchange() {
    double val;

    setState(() {
      if (__gram >= 20) {
        val = __gram / this.grams;

        __cal = (this.calories * val).toInt();
        __fat = (this.fats * val).toInt();
        __carb = (this.carbon * val).toInt();
        __prot = (this.protiens * val).toInt();

        caloriesController.text = __cal.toString();
        carbonController.text = __carb.toString();
        fatsController.text = __fat.toString();
        protiensController.text = __prot.toString();

        print(' ----------__cal-----' + __cal.toString());
        print(' ----------__fat-----' + __fat.toString());
        print(' ----------__carb-----' + __carb.toString());
        print(' ----------__carb-----' + __prot.toString());
      } else {
        print('Enter Greater than 50');
      }
    });
  }
}
