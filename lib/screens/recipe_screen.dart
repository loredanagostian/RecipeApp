import 'package:first_app/managers/dummyjason.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  Recipe recipeModel;
  RecipeDetailScreen(this.recipeModel, {Key? key}) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getIngredients(widget.recipeModel.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var ingredient = snapshot.data;
            widget.recipeModel.ingredients = ingredient;
            return SingleChildScrollView(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 209, 110, 252),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.recipeModel.image,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Scrollbar(
                        child: ListView.builder(
                          itemCount: ingredient.length,
                          itemBuilder: (context, index) {
                            var item = ingredient[index];

                            return ListTile(
                              title: Text(item.name),
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else {
            return const Text('Eroare', style: TextStyle(fontSize: 50));
          }
        },
      ),
    );
  }
}
