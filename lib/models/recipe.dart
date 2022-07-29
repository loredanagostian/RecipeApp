import 'package:first_app/models/ingredient.dart';

class Recipe {
  final String id;
  final String title;
  List<Ingredient> ingredients;
  final String image;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'].toString(),
      title: json['title'],
      ingredients: [],
      image: json['image'],
    );
  }
}
