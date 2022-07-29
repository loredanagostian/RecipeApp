import 'package:first_app/managers/dummyjason.dart';
import 'package:first_app/screens/recipe_screen.dart';
import 'package:flutter/material.dart';
import '../recipe_item.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  // var recipes = parseRecipes(dummyResponse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: getRecipes(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              var recipes = snapshot.data;
              return ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  var item = recipes[index];
                  return GestureDetector(
                    onTap: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RecipeDetailScreen(item);
                          })
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: RecipeItem(
                        title: item.title,
                        image: item.image,
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 255, 117, 108)),
              );
            else {
              return const Text('Eroare', style: TextStyle(fontSize: 50));
            }
          }),
    );
  }
}
