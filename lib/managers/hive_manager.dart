import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';

class HiveManager {
  late Box<Recipe> recipeBox;
  late Box<UserCredential> userBox;
  static final instance = HiveManager._internal();

  factory HiveManager() {
    return instance;
  }

  HiveManager._internal();

  Future<void> initHiveManager() async {
    Hive.registerAdapter(RecipeAdapter());

    recipeBox = await Hive.openBox('recipes');
    userBox = await Hive.openBox('users');
  }
}
