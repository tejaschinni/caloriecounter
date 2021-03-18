import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalCalData {
  int tcalories, tcrabs, tfat, tprotiens;
  final DocumentReference reference;

  TotalCalData.fromMap(Map<String, dynamic> map, {this.reference})
      : tcalories = map['tcalories'],
        tcrabs = map['tcrabs'],
        tfat = map['tfat'],
        tprotiens = map['tprotiens'];

  TotalCalData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
