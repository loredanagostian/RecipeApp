import 'package:first_app/screens/recipe_screen.dart';
import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  final String title;
  final List<dynamic> ingredients;
  final String image;

  const RecipeItem({
    required this.title,
    required this.ingredients,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 33, 18, 13).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        border: Border.all(
          color: Color.fromARGB(255, 33, 18, 13),
          width: 1.5,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              fit: BoxFit.fill,
              height: 50,
            ),
          ),
          rightSide(),
        ],
      ),
    );
  }

  Widget rightSide() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 33, 18, 13),
              ),
            ),
            ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                var item = ingredients[index];

                return ListTile(
                  title: Text(item),
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
