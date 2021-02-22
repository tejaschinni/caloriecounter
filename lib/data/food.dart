import 'package:flutter/material.dart';

class Food {
  String recipesName;
  int grams, carbon, protines, fat, calories;

  Food(
      {this.calories,
      this.carbon,
      this.fat,
      this.grams,
      this.protines,
      this.recipesName});
}
