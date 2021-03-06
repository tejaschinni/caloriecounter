import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDetailPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  UserDetailPage({this.gUser, this.selectedDate, this.signOut});
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController weigthController = TextEditingController();

  String userName;
  int weigth, mobile;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      widget.selectedDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
    });
    print(userNameController);
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
                          userName = val;
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
      'name': userName,
      'mobile': mobile,
      'weigth': weigth,
      'date': widget.selectedDate
    });
  }
}
