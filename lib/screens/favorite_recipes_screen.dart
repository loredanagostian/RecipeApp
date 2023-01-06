import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/screens/recipes_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/recipe_item_tile.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> recipes =
      FirebaseFirestore.instance.collection('recipes').snapshots();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const MainScreen();
        }), (r) {
          return false;
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 80, 202, 213),
          title: const Text(
            "Favorites",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
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
                            favVal: item['favValue'],
                            isFromFav: true,
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
      ),
    );
  }
}
