import 'package:flutter/material.dart';

class RecipeModal {
  final String image;
  final String name;
  final String? recipe;

  RecipeModal({required this.image, required this.name, this.recipe});
}