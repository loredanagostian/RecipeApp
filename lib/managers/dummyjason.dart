import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/constants/app_urls.dart';
import 'package:first_app/managers/authentication_manager.dart';
import 'package:first_app/managers/hive_manager.dart';
import 'package:first_app/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../constants/app_urls.dart';

import '../models/ingredient.dart';

Future<List<Recipe>> parseRecipes(String responseBody) async {
  final parsed =
      jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();

  List<Recipe> recipes = parsed
      .map<Recipe>((json) => Recipe.fromJson(json as Map<String, dynamic>))
      .toList();

  //check if datas are in firestore
  for (var recipe in recipes) {
    CollectionReference recipeCollection =
        FirebaseFirestore.instance.collection('recipes');

    if (AuthenticationManager.isNew) {
      recipeCollection
          .where('title', isEqualTo: recipe.title)
          .get()
          .then((snapshot) => snapshot.docs.forEach((querySnapshot) {
                for (QueryDocumentSnapshot docSnapshot in snapshot.docs) {
                  docSnapshot.reference
                      .delete()
                      .then((value) => print('Recipe deleted from favorites'))
                      .catchError(
                          (error) => print('Failed to add recipe: $error'));
                  ;
                }
              }));
    }

    var exist =
        await recipeCollection.where('title', isEqualTo: recipe.title).get();

    if (exist.docs.isNotEmpty) {
      recipe.favValue = true;
    } else {
      recipe.favValue = false;
      // print("Doc doesn't exits");
    }

    HiveManager.instance.recipeBox.put(recipe.id, recipe);
  }

  return recipes;
}

List<Ingredient> parseIngredients(String responseBody) {
  final parsed = jsonDecode(responseBody)['extendedIngredients']
      .cast<Map<String, dynamic>>();
  return parsed
      .map<Ingredient>(
          (json) => Ingredient.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<List<Recipe>> getRecipes() async {
  Uri url = Uri.parse(AppUrls.recipeListURL);
  bool hasInternetConnection =
      await InternetConnectionCheckerPlus().hasConnection;
  var response = await http.get(url);
  if (hasInternetConnection && response.statusCode != 402) {
    if (response.statusCode == 200) {
      return parseRecipes(response.body);
    }
  } else {
    List<Recipe> listRecipes = HiveManager.instance.recipeBox.values.toList();

    for (var recipe in listRecipes) {
      CollectionReference recipeCollection =
          FirebaseFirestore.instance.collection('recipes');

      var exist =
          await recipeCollection.where('title', isEqualTo: recipe.title).get();

      if (exist.docs.isNotEmpty) {
        recipe.favValue = true;
      } else {
        recipe.favValue = false;
        // print("Doc doesn't exits");
      }

      HiveManager.instance.recipeBox.put(recipe.id, recipe);
    }

    return listRecipes;
  }

  return [];
}

Future<List<Ingredient>> getIngredients(String id) async {
  AppUrls appUrls = AppUrls();
  String recipeInfoURL = appUrls.getRecipeInfoURL(id);
  Uri url = Uri.parse(recipeInfoURL);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return parseIngredients(response.body);
  }
  return [];
}

const dynamic dummyResponse =
    '[{"id": "r1","title": "Chorizo & mozzarella gnocchi bake","ingredients": ["1 tbsp olive oil", "1 onion , finely chopped", "2 garlic cloves , crushed", "120g chorizo, diced", "2 x 400g cans chopped tomatoes", "600g fresh gnocchi", "125g mozzarella ball, cut into chunks"], "image": "assets/icons/chorizo.png"}, {"id": "r2","title": "Easy pancakes","ingredients": ["100g plain flour", "2 large eggs", "300ml milk", "1 tbsp sunflower or vegetable oil, plus a little extra for frying", "lemon wedges to serve (optional)"], "image": "assets/icons/pancakes.png"},{"id": "r3","title": "Vegetarian chilli","ingredients": ["400g pack oven-roasted vegetables", "1 can kidney beans in chilli sauce", "1 can chopped tomatoes", "1 ready-to-eat mixed grain pouch"], "image": "assets/icons/chilli.png"}]';
