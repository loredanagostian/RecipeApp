import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipeItem extends StatefulWidget {
  final String title;
  final String image;
  bool favVal;
  bool isFromFav;

  RecipeItem({
    Key? key,
    required this.title,
    required this.image,
    required this.favVal,
    this.isFromFav = false,
  }) : super(key: key);

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection('recipes');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 33, 18, 13).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 209, 110, 252),
          width: 1.5,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              widget.image,
              fit: BoxFit.fill,
              height: 50,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          rightSide(),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                widget.favVal = !widget.favVal;
                if (widget.favVal) {
                  //add
                  recipeCollection
                      .add({
                        'title': widget.title,
                        'image': widget.image,
                        'favValue': true,
                      })
                      .then((value) => print('Recipe added to favorites'))
                      .catchError(
                          (error) => print('Failed to add recipe: $error'));
                } else {
                  //delete
                  recipeCollection
                      .where('title', isEqualTo: widget.title)
                      .get()
                      .then((snapshot) =>
                          snapshot.docs.forEach((querySnapshot) {
                            for (QueryDocumentSnapshot docSnapshot
                                in snapshot.docs) {
                              docSnapshot.reference
                                  .delete()
                                  .then((value) =>
                                      print('Recipe deleted from favorites'))
                                  .catchError((error) =>
                                      print('Failed to add recipe: $error'));
                              ;
                            }
                          }));
                }
              });
            },
            icon: Icon(widget.favVal ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
    );
  }

  Widget rightSide() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 33, 18, 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
