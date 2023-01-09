import 'package:first_app/managers/dummyjason.dart';
import 'package:first_app/screens/favorite_recipes_screen.dart';
import 'package:first_app/screens/recipe_dialog_screen.dart';
import 'package:flutter/material.dart';
import '../managers/authentication_manager.dart';
import '../widgets/recipe_item_tile.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 80, 202, 213),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.favorite_border_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getRecipes(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              var recipes = snapshot.data;
              return Column(
                children: [
                  ListView.builder(
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
                            favVal: item.favValue,
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        AuthenticationManager.signOutUser();

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 117, 108),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign me out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
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
