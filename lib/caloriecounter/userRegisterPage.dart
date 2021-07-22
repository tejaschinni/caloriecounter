import 'package:caloriecounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRegisterPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  //DateTime selectedDate;

  UserRegisterPage(this.gUser, this.signOut);
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController weigthController = TextEditingController();

  String name = '';
  int weigth = 0, mobile = 0;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // widget.selectedDate = DateTime(
      //     DateTime.now().year, DateTime.now().month, DateTime.now().day);
      // userNameController.text = widget.userData.name.toString();
      // weigthController.text = widget.userData.weigth.toString();
      // mobileController.text = widget.userData.mobile.toString();
    });

    print(widget.gUser.email.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userDetail();
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          Center(
            child: InkWell(
              child: Icon(Icons.person),
              onTap: () {
                widget.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (contex) => SigInPage()));
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('User Name'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: TextField(
                      controller: userNameController,
                      onChanged: (String val) {
                        setState(() {
                          name = val;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Mobile'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      onChanged: (String val) {
                        setState(() {
                          mobile = int.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Weigth'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: TextField(
                      controller: weigthController,
                      keyboardType: TextInputType.number,
                      onChanged: (String val) {
                        setState(() {
                          weigth = int.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> userDetail() async {
    collection.doc(widget.gUser.email).set({
      'name': name,
      'mobile': mobile,
      'weigth': weigth,
      //'date': widget.selectedDate
    });
  }
}
