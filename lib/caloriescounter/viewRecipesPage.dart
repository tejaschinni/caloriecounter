import 'package:caloriecounter/data/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewRecipesPage extends StatefulWidget {
  Food food;
  @override
  _ViewRecipesPageState createState() => _ViewRecipesPageState();
}

class _ViewRecipesPageState extends State<ViewRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('food').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final food = snapshot.data.docs;
          return ListView.builder(
              itemCount: food.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(food[index]['name']),
                    subtitle: Text('P =  ' +
                        food[index]['protiens'].toString() +
                        ' Cal=  ' +
                        food[index]['calories'].toString() +
                        ' Carn=  ' +
                        food[index]['carbon'].toString() +
                        ' F=  ' +
                        food[index]['fats'].toString()),
                    trailing: Text(
                      'Grams=  ' + food[index]['grams'].toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
