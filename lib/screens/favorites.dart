import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../recipe_item.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> recipes =
      FirebaseFirestore.instance.collection('recipes').snapshots();
  // late bool fav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: recipes,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var recipeData = snapshot.requireData;
              return Column(
                children: [
                  ListView.builder(
                    itemCount: recipeData.size,
                    itemBuilder: (context, index) {
                      var item = recipeData.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: RecipeItem(
                          title: item['title'],
                          image: item['image'],
                          initialValue: true,
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 255, 117, 108),
                  ),
                ),
              );
            } else {
              return const Text('Eroare', style: TextStyle(fontSize: 50));
            }
          },
        ),
      ),
    );
  }
}
