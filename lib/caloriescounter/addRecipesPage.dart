import 'package:flutter/material.dart';

import '../data/food.dart';

class AddRecipesPage extends StatefulWidget {
  Function signOut;
  AddRecipesPage({this.signOut});
  @override
  _AddRecipesPageState createState() => _AddRecipesPageState();
}

class _AddRecipesPageState extends State<AddRecipesPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  String name;
  int grams, carbon, fats, protiens, calories;

  List<Food> item = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Recipes'),
        actions: [
          InkWell(
            child: Icon(Icons.home),
            onTap: () {
              widget.signOut();
            },
          )
        ],
      ),
      body: Container(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Recipe Name'),
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
                        controller: nameController,
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Grams'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                      child: TextField(
                        controller: gramsController,
                        keyboardType: TextInputType.number,
                        onChanged: (String val) {
                          setState(() {
                            grams = int.parse(val);
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Carbon'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                      child: TextField(
                        controller: carbonController,
                        keyboardType: TextInputType.number,
                        onChanged: (String val) {
                          setState(() {
                            carbon = int.parse(val);
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Protiens'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                      child: TextField(
                        controller: protiensController,
                        keyboardType: TextInputType.number,
                        onChanged: (String val) {
                          setState(() {
                            protiens = int.parse(val);
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Calories'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                      child: TextField(
                        controller: caloriesController,
                        keyboardType: TextInputType.number,
                        onChanged: (String val) {
                          setState(() {
                            calories = int.parse(val);
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Fat'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                      child: TextField(
                        controller: fatsController,
                        keyboardType: TextInputType.number,
                        onChanged: (String val) {
                          setState(() {
                            fats = int.parse(val);
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
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(item[index].recipesName),
                            subtitle: Text("Protiens =" +
                                item[index].protines.toString() +
                                " "
                                    "Calories=" +
                                item[index].calories.toString() +
                                " Carbon=" +
                                item[index].carbon.toString() +
                                " Fat=" +
                                item[index].fat.toString()),
                            trailing:
                                Text("Grams=" + item[index].grams.toString()),
                          );
                        })),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          for (int i = 0; i < item.length; i++) {
            print(item[i].recipesName);
          }
          print('-----------------' + name);
          Food a = Food(
              calories: calories,
              recipesName: name,
              fat: fats,
              carbon: carbon,
              protines: protiens,
              grams: grams);
          setState(() {
            item.add(a);
            print(item.length);
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
          });
        },
      ),
    );
  }
}
