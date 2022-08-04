import 'package:hive/hive.dart';
import '../models/recipe.dart';

class HiveManager {
  late Box<Recipe> recipeBox;
  static final instance = HiveManager._internal();

  factory HiveManager() {
    return instance;
  }

  HiveManager._internal();

  Future<void> initHiveManager() async {
    Hive.registerAdapter(RecipeAdapter());

    recipeBox = await Hive.openBox('recipes');
  }
}
