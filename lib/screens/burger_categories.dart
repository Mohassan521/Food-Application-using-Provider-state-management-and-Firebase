import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/bottom_container.dart';
import 'package:food_app/screens/Burger_detail_page.dart';
import 'package:food_app/screens/home_page.dart';

import '../models/burgers_categories_model.dart';

class BurgerCategories extends StatelessWidget {
  List<BurgerCategoriesModel> list = [];

  BurgerCategories({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b2b2b),
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Burger Categories'),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('burgerCategories').doc('BbQmbVYrLGkDwFk11sCc').collection('Burgers').snapshots(),
          builder: (context, snapshot){
            if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No items to display'),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    var document = snapshot.data!.docs[index];

                    return BottomContainer(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(
                            image: document.get('image'),
                            name: document.get('Name'),
                            price: document.get('Price'),
                            catchphrase: document.get('catchphrase'),
                          )));
                        },
                        image: document.get('image'),
                        price: document.get('Price'),
                        name: document.get('Name')
                    );
                  }
              ),
            );
          }
      )
    );
  }
}
