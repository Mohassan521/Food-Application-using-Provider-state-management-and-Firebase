import 'package:flutter/material.dart';

class RecipeDetailsPage extends StatelessWidget {

  final String image;
  final String name;
  final String recipe;

  const RecipeDetailsPage({super.key, required this.image, required this.name, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2b2b2b),
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(image, width: double.infinity, height: 90, fit: BoxFit.cover,),
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xff3a3e3e),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      'Recipe',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      recipe,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
