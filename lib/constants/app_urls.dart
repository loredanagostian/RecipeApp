class AppUrls {
  static const String apiKey = '22377100b4aa4bd98ddf10ae00401b58';
  static const String recipeListURL =
      'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey';

  String getRecipeInfoURL(String id) {
    return 'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';
  }
}
