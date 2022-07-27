import 'package:first_app/models/ingredient.dart';
import 'package:flutter/material.dart';

class Recipe {
  final String id;
  final String title;
  final List<dynamic> ingredients;
  final String image;

  const Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    // var recipeIngredients = json['extendedIngredients'];
    // List<Ingredient> ingredientsList = List<Ingredient>.from(
    //     recipeIngredients.map((x) => Ingredient.fromJson(x)));

    return Recipe(
      id: json['id'].toString(),
      title: json['title'],
      // ingredients: ingredientsList,
      ingredients: ((json['extendedIngredients']) ?? []) as List<dynamic>,
      image: json['image'],
    );
  }
}
