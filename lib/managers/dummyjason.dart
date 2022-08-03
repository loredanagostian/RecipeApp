import 'dart:convert';

import 'package:first_app/constants/app_urls.dart';
import 'package:first_app/models/recipe.dart';
import 'package:http/http.dart' as http;
import '../constants/app_urls.dart';

import '../models/ingredient.dart';

List<Recipe> parseRecipes(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();
  return parsed
      .map<Recipe>((json) => Recipe.fromJson(json as Map<String, dynamic>))
      .toList();
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
  var response = await http.get(url);

  print('status code:');
  print(response.statusCode);

  if (response.statusCode == 200) {
    return parseRecipes(response.body);
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
