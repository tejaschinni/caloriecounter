import 'package:caloriecounter/caloriecounter/addRecipeToDailyIntake.dart';
import 'package:caloriecounter/caloriecounter/editRecipePage.dart';
import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ListViewSearchBar extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  List<Recipies> userRecipeList;
  DateTime selectedDate;
  Function setRecipeValue;
  ListViewSearchBar(this.gUser, this.signOut, this.userRecipeList,
      this.selectedDate, this.setRecipeValue);
  @override
  _ListViewSearchBarState createState() => _ListViewSearchBarState();
}

class _ListViewSearchBarState extends State<ListViewSearchBar> {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  List<Recipies> _foundRecipe = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foundRecipe = widget.userRecipeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: _foundRecipe.length > 0
                  ? ListView.builder(
                      itemCount: _foundRecipe.length,
                      itemBuilder: (context, index) => InkWell(
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        _foundRecipe[index].name.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        _foundRecipe[index].grams.toString() +
                                            'gram',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ' ',
                                        style: TextStyle(
                                            color: Colors.blue.shade900),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'C  :  ' +
                                                _foundRecipe[index]
                                                    .calories
                                                    .toString() +
                                                'g',
                                            style: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            'C  :  ' +
                                                _foundRecipe[index]
                                                    .carbon
                                                    .toString() +
                                                'g',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'P  :  ' +
                                                _foundRecipe[index]
                                                    .carbon
                                                    .toString() +
                                                'g',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blueAccent),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'F : ' +
                                                _foundRecipe[index]
                                                    .fats
                                                    .toString() +
                                                'g',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orangeAccent),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Divider()
                            ],
                          ),
                        ),
                        onLongPress: () {},
                        onTap: () {
                          widget.setRecipeValue(
                              _foundRecipe[index].name,
                              _foundRecipe[index].calories,
                              _foundRecipe[index].grams,
                              _foundRecipe[index].carbon,
                              _foundRecipe[index].protines,
                              _foundRecipe[index].fats);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (contex) => AddRecipeToDailyIntake(
                          //               widget.gUser,
                          //               widget.signOut,
                          //               widget.selectedDate,
                          //               _foundRecipe[index].reference.id,
                          //               _foundRecipe[index],
                          //             )));
                          print("On clicked on a particular recipe");
                          print('--------------------' +
                              _foundRecipe[index].name.toString());
                        },
                      ),
                    )
                  : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Recipies> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.userRecipeList;
    } else {
      results = widget.userRecipeList
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundRecipe = results;
    });
  }

  Future<void> deleteRecpe(var document) async {
    firestore
        .doc(widget.gUser.email)
        .collection('recipes')
        .doc(document)
        .delete();

    setState(() {});
  }
}
