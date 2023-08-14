import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/burgers_categories_model.dart';
import 'package:food_app/models/categories_model.dart';
import 'package:food_app/screens/Burger_detail_page.dart';
import 'package:food_app/screens/Drinks_page.dart';
import 'package:food_app/screens/burger_categories.dart';
import 'package:food_app/screens/cart_page.dart';
import 'package:food_app/screens/login_page.dart';
import 'package:food_app/utils.dart';
import 'package:provider/provider.dart';
import '../provider/my_provider.dart';
import 'Recipes_page.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModel> categoriesModel = [];
  List<CategoriesModel> recipesModel = [];
  List<CategoriesModel> drinksModel = [];
  List<CategoriesModel> burgersModel = [];
  List<CategoriesModel> allItems = [];
  List<BurgerCategoriesModel> burgersCategoriesModel = [];

  Widget itemContainer(
      {required Function() onTap,
      required String image,
      required String title,
      required String price}) {
    return GestureDetector(
      onTap: onTap,
      child: Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 5),
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: const Color(0xff3a3e3e),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(image, width: double.infinity, height: 127, fit: BoxFit.cover,),
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                leading: Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                trailing: Text(
                  '\$$price',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoriesContainer(
      {required String image,
      required String name,
      required Function() OnTap}) {
    return Column(
      children: [
        InkWell(
          onTap: OnTap,
          child: Container(
            margin: const EdgeInsets.only(left: 18),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(image)),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }

  Widget pizzas() {
    return Row(
      children: categoriesModel
          .map((e) =>
              categoriesContainer(image: e.image, name: e.name, OnTap: () {}))
          .toList(),
    );
  }

  Widget allRecipes() {
    return Row(
      children: recipesModel
          .map((e) =>
              categoriesContainer(image: e.image, name: e.name, OnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipesPage()));
              }))
          .toList(),
    );
  }

  Widget allDrinks() {
    return Row(
      children: drinksModel
          .map((e) =>
              categoriesContainer(image: e.image, name: e.name, OnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DrinksPage()));
              })
      )
          .toList(),
    );
  }

  Widget allBurgers() {
    return Row(
      children: burgersModel
          .map((e) => categoriesContainer(
              image: e.image,
              name: e.name,
              OnTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BurgerCategories(
                              list: burgersCategoriesModel,
                            )));
              }))
          .toList(),
    );
  }

  Widget allItemsCategories(){
    return Row(
      children: allItems.map((e) => categoriesContainer(image: e.image, name: e.name, OnTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      })).toList()
    );
  }

  Future<void> SignOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  void signOutAndRedirect(BuildContext context) async {
    await SignOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }


  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getAllBurgers();
    provider.getCategories();
    provider.getRecipes();
    provider.getDrinks();
    provider.getBurgers();
    provider.getAllItems();
    burgersCategoriesModel = provider.throwAllBurgersList;
    categoriesModel = provider.throwList;
    recipesModel = provider.throwRecipeList;
    drinksModel = provider.throwDrinksList;
    burgersModel = provider.throwBurgersList;
    allItems = provider.throwAllItems;
    return Scaffold(
        backgroundColor: Color(0xff2b2b2b),
        drawer: Drawer(
          child: Container(
            color: const Color(0xff2b2b2b),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: const AssetImage('images/drawerImage.png'),
                            fit: BoxFit.cover),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage('images/profile.jpg'),
                      ),
                      accountName: Text('Hassoo'),
                      accountEmail: Text('Hassoo@gmail.com')),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Cart',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Order',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Change',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    title: InkWell(
                      onTap: (){
                        signOutAndRedirect(context);
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          actions: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: badges.Badge(
                  badgeContent: Text(provider.cartItems.length.toString(), style: TextStyle(color: Colors.white),),
                  badgeAnimation: badges.BadgeAnimation.rotation(
                    animationDuration: Duration(milliseconds: 300)
                  ),
                  child: IconButton(icon: const Icon(Icons.shopping_bag),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                    },
                  ),
                ),
              ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Search here',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color(0xff3a3e3e),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.search, color: Colors.white)),
              ),
            ),
            SingleChildScrollView(
              child: Row(
                children: [
                  allItemsCategories(),
                  pizzas(),
                  allBurgers(),
                  allRecipes(),
                  allDrinks()
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('burgerCategories').doc('BbQmbVYrLGkDwFk11sCc').collection('All').snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    Utils.flushbarErrorMessage('An Error has occured', context);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                        child: CircularProgressIndicator()
                    );
                  }
                  if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                      const Center(
                          child: Text('No data to display', style: TextStyle(color: Colors.white),)
                      );
                  }

                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        var document = snapshot.data!.docs[index];

                        return itemContainer(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(
                                image: document.get('image'),
                                name: document.get('Name'),
                                price: document.get('Price'),
                                catchphrase: document.get('catchphrase'),
                              )));
                            },
                            image: document.get('image').toString(),
                            title: document.get('Name').toString(),
                            price: document.get('Price').toString()
                        );
                      }
                  );
                }
              ),
            )
          ],
        ));
  }
}
