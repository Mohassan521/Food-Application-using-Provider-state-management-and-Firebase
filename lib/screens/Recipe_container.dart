import 'package:flutter/material.dart';

class RecipeContainer extends StatelessWidget {
  final String image;
  final String name;
  final Function() onTap;

  const RecipeContainer({super.key, required this.onTap,required this.image, required this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff3a3e3e),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   radius: 55,
            //   backgroundImage: NetworkImage(image),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(image, width: 250, height: 120, fit: BoxFit.cover,),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Text(
                name,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}