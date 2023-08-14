import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/bottom_container.dart';
import 'package:food_app/screens/drinks_detail.dart';
import 'package:food_app/utils.dart';

class DrinksPage extends StatelessWidget {
  const DrinksPage({super.key});

  @override
  Widget build(BuildContext context) {

    final drinksStream = FirebaseFirestore.instance.collection('burgerCategories').doc('BbQmbVYrLGkDwFk11sCc').collection('Drinks').snapshots();

    return Scaffold(
      backgroundColor: const Color(0xff2b2b2b),
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Drinks Categories'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: drinksStream,
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
              const Center(
                  child: Text('No data to display'));
              }

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  var document = snapshot.data!.docs[index];

                  return BottomContainer(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DrinksDetailsPage(
                          image: document.get('image'),
                          name: document.get('Name'),
                          price: document.get('Price'),
                        )));
                      },
                      image: document.get('image'),
                      name: document.get('Name'),
                      price: document.get('Price'),
                  );
                }
            );
          }),
    );
  }
}
