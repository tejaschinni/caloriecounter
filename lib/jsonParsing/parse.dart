import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Food>> fetchFodds(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://raw.githubusercontent.com/tejaschinni/caloriecounter/main/food.json'));

  // Use the compute function to run parseFodds in a separate isolate.
  return compute(parseFodds, response.body);
}

// A function that converts a response body into a List<Food>.
List<Food> parseFodds(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Food>((json) => Food.fromJson(json)).toList();
}

class Food {
  final String gram;
  final String calories;
  final String fats;
  final String carbon;
  final String protein;
  final String name;

  Food({
    required this.gram,
    required this.calories,
    required this.fats,
    required this.carbon,
    required this.protein,
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      gram: json['gram'] as String,
      calories: json['calories'] as String,
      fats: json['fats'] as String,
      carbon: json['carbon'] as String,
      protein: json['protein'] as String,
      name: json['name'] as String,
    );
  }
}

class LibraryFood extends StatefulWidget {
  const LibraryFood({Key? key}) : super(key: key);

  @override
  _LibraryFoodState createState() {
    return _LibraryFoodState();
  }
}

class _LibraryFoodState extends State<LibraryFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('title'),
      // ),
      body: FutureBuilder<List<Food>>(
        future: fetchFodds(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? FoddsList(Fodds: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Parse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('title'),
      // ),
      body: FutureBuilder<List<Food>>(
        future: fetchFodds(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          return snapshot.hasData
              ? FoddsList(Fodds: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class FoddsList extends StatelessWidget {
  final List<Food> Fodds;

  FoddsList({Key? key, required this.Fodds}) : super(key: key);

  List<Food> _foundFood = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: Fodds.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Fodds[index].name,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          Fodds[index].gram + 'gram',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ' ',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                        Row(
                          children: [
                            Text(
                              'C  :  ' + Fodds[index].calories + 'g',
                              style: TextStyle(
                                  color: Colors.blue.shade900, fontSize: 10),
                            ),
                            Text(
                              'C  :  ' + Fodds[index].carbon + 'g',
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'P  :  ' + Fodds[index].carbon + 'g',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.blueAccent),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'F : ' + Fodds[index].fats + 'g',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.orangeAccent),
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
          );
        },
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Food> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = Fodds;
    } else {
      results = Fodds.where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    // setState(() {
    //   Fodds = results;
    // });
  }
}
