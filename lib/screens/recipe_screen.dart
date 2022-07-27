import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipeModel;
  RecipeDetailScreen(this.recipeModel);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color.fromARGB(255, 255, 117, 108),
          width: 2,
        ),
      ),
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
              itemCount: recipeModel.ingredients.length,
              itemBuilder: (context, index) {
                var item = recipeModel.ingredients[index];

                return ListTile(
                  title: Text(item.name),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                );
              },
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
