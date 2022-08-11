import 'package:first_app/models/ingredient.dart';
import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  List<Ingredient> ingredients;
  @HiveField(3)
  final String image;
  @HiveField(4)
  late bool? favValue;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.image,
    this.favValue = false,
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
