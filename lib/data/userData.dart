import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData {
  String name;
  int mobile, weigth;
  Timestamp date;
  final DocumentReference reference;

  UserData.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        weigth = map['weigth'],
        date = map['date'],
        mobile = map['mobile'];

  UserData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
