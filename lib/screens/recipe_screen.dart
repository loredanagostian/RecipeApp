import 'package:first_app/managers/dummyjason.dart';
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  Recipe recipeModel;
  RecipeDetailScreen(this.recipeModel);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getIngredients(recipeModel.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                var ingredient = snapshot.data;
                recipeModel.ingredients = ingredient;
                return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 255, 117, 108),
                        width: 2,
                      ),
                    ),
                    // child: SingleChildScrollView(
                    //   child: FutureBuilder(
                    //     future: getIngredients(recipeModel.id),
                    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    //       if (snapshot.hasData) {
                    //         var ingredient = snapshot.data;
                    //         recipeModel.ingredients = ingredient;
                    // return
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  recipeModel.image,
                                  height: 100,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ListView.builder(
                                itemCount: ingredient.length,
                                itemBuilder: (context, index) {
                                  var item = ingredient[index];

                                  return ListTile(
                                    title: Text(item.name),
                                    visualDensity: VisualDensity(
                                        horizontal: 0, vertical: -4),
                                  );
                                },
                                shrinkWrap: true,
                              )
                            ])));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 33, 18, 13)),
                );
              } else {
                return const Text('Eroare', style: TextStyle(fontSize: 50));
              }
            },
          ),
        ],
        // ),
      ),
    );
  }
}
