import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/Recipe_container.dart';
import 'package:food_app/screens/bottom_container.dart';
import 'package:food_app/screens/recipe_details.dart';

import '../utils.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {

  final recipes = FirebaseFirestore.instance.collection('burgerCategories').doc('BbQmbVYrLGkDwFk11sCc').collection('Recipes').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b2b2b),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Recipes Page'),
        leading: IconButton(onPressed: (){
            Navigator.pop(context);
        },
          icon: const Icon(Icons.arrow_back, color: Colors.white,),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: recipes,
        builder: (context, snapshot){
          if(snapshot.hasError){
            Utils.flushbarErrorMessage('An error has occured', context);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: CircularProgressIndicator()
            );
          }

          if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return Center(
              child: Text('No data to display'),
            );
          }

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                var document = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: RecipeContainer(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailsPage(
                            image: document.get('image'), 
                            name: document.get('Name'), 
                            recipe: document.get('recipe')
                        )));
                      },
                      image: document.get('image'),
                      name: document.get('Name'),
                  ),
                );
              });
        },
      ),
    );
  }
}
