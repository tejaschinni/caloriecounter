import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Food {
  String name;
  int calories, carbon, fats, grams, protiens;
  final DocumentReference reference;

  Food.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        grams = map['grams'],
        carbon = map['carbon'],
        protiens = map['protiens'],
        fats = map['fats'],
        calories = map['calories'];

  Food.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
