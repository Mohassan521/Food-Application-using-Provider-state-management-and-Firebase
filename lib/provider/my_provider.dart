import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/Recipe_model.dart';
import '../models/burgers_categories_model.dart';
import '../models/cart_model.dart';
import '../models/categories_model.dart';
import '../utils.dart';

class MyProvider extends ChangeNotifier {
  List<CategoriesModel> categorieslist = [];
  CategoriesModel? categoriesModel;
  
  final burgerCategories = FirebaseFirestore.instance.collection('burgerCategories').doc('BbQmbVYrLGkDwFk11sCc').collection('Burgers');
  final recipes = FirebaseFirestore.instance.collection('burgerCategories').doc('BbQmbVYrLGkDwFk11sCc').collection('Recipes');
  
  
  Future<void> getCategories() async {
    List<CategoriesModel> newCategorieslist = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ou4mPxkF3tW8lp2DQ61m')
        .collection('burger')
        .get();
    querySnapshot.docs.forEach((element) {
      categoriesModel = CategoriesModel(
          image: element.get('image'), name: element.get('name'));
      // print(categoriesModel?.name);
    });
    newCategorieslist.add(categoriesModel!);
    categorieslist = newCategorieslist;
  }

  get throwList {
    return categorieslist;
  }

  ///////////////////////////////////////////

  List<CategoriesModel> recipeslist = [];
  CategoriesModel? recipesModel;

  Future<void> getRecipes() async {
    List<CategoriesModel> newRecipesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ou4mPxkF3tW8lp2DQ61m')
        .collection('Recipe')
        .get();
    querySnapshot.docs.forEach((element) {
      recipesModel = CategoriesModel(
          image: element.get('image'), name: element.get('name'));
      print(recipesModel?.name);
    });
    newRecipesList.add(recipesModel!);
    recipeslist = newRecipesList;
  }

  get throwRecipeList {
    return recipeslist;
  }

  ////////////////////////////////

  List<CategoriesModel> drinkslist = [];
  CategoriesModel? drinksModel;

  Future<void> getDrinks() async {
    List<CategoriesModel> newDrinksList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ou4mPxkF3tW8lp2DQ61m')
        .collection('Drinks')
        .get();
    querySnapshot.docs.forEach((element) {
      drinksModel = CategoriesModel(
          image: element.get('image'), name: element.get('name'));
      print(drinksModel?.name);
    });
    newDrinksList.add(drinksModel!);
    drinkslist = newDrinksList;
  }

  get throwDrinksList {
    return drinkslist;
  }

  List<CategoriesModel> burgerslist = [];
  CategoriesModel? burgersModel;

  Future<void> getBurgers() async {
    List<CategoriesModel> newBurgersList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ou4mPxkF3tW8lp2DQ61m')
        .collection('Burgers')
        .get();
    querySnapshot.docs.forEach((element) {
      burgersModel = CategoriesModel(
          image: element.get('image'), name: element.get('name'));
      // print(drinksModel?.name);
    });
    newBurgersList.add(burgersModel!);
    burgerslist = newBurgersList;
  }

  get throwBurgersList {
    return burgerslist;
  }

  ////////////////////Burger categories list/////////////////////

  List<BurgerCategoriesModel> allBurgerslist = [];
  BurgerCategoriesModel? allBurgersModel;

  Future<void> getAllBurgers() async {
    List<BurgerCategoriesModel> newAllBurgersList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('burgerCategories')
        .doc('BbQmbVYrLGkDwFk11sCc')
        .collection('Burgers')
        .get();
    querySnapshot.docs.forEach((element) {
      allBurgersModel = BurgerCategoriesModel(
          image: element.get('image'),
          name: element.get('Name'),
          price: element.get('Price'));
    });
    newAllBurgersList.add(allBurgersModel!);
    allBurgerslist = newAllBurgersList;
  }

  get throwAllBurgersList {
    return allBurgerslist;
  }
  
  
  
  List<RecipeModal> recipeModal = [];
  RecipeModal? _recipeModal;
  
  Future<void> getAllRecipes() async {
    List<RecipeModal> newRecipeModal = [];
    QuerySnapshot querySnapshot = recipes as QuerySnapshot<Object?>;
    querySnapshot.docs.forEach((element) {
      _recipeModal = RecipeModal(
          image: element.get('image'),
          name: element.get('name')
      );
      newRecipeModal.add(_recipeModal!);
      recipeModal = newRecipeModal;
    });
  }

  get throwAllRecipes{
    return recipeModal;
  }

  List<CategoriesModel> allItemsModal = [];
  CategoriesModel? _allItemsModal;

  Future<void> getAllItems() async {
    List<CategoriesModel> newallItemsModal = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('categories').doc('ou4mPxkF3tW8lp2DQ61m').collection('All').get();
    querySnapshot.docs.forEach((element) {
      _allItemsModal = CategoriesModel(
          image: element.get('image'),
          name: element.get('Name')
      );
      newallItemsModal.add(_allItemsModal!);
      allItemsModal = newallItemsModal;
    });
  }

  get throwAllItems{
    return allItemsModal;
  }

  List<CartModel> cartItems = [];
  List<CartModel> newCartItems = [];

  CartModel? cartModel;

  bool isItemInCart(String itemName){
    return newCartItems.any((element) => element.name == itemName);
  }

  void addToCart({required String image,
    required String name,
    required int price,
    required int qty,
    String? catchphrase})
  {

    if(isItemInCart(name)){
      // Utils.flushbarErrorMessage('Product is already added in Cart', context as BuildContext);
      Utils.ErrorMessage('Product is already added to cart');
    }
    else{
      cartModel = CartModel(
          image: image,
          name: name,
          price: price,
          catchphrase: catchphrase != null ? catchphrase : '', quantity: qty
      );
      newCartItems.add(cartModel!);
      Utils.toastMessage('An item is added');
    }
    cartItems = newCartItems;
    notifyListeners();
  }

  get throwCartItems{
    return cartItems;
  }

  int totalPrice(){
    int total = 0;
    cartItems.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  late int deleteIndex;
  void getDeleteIndex(int index){
    deleteIndex = index;
  }

  void delete(){
    cartItems.removeAt(deleteIndex);
    notifyListeners();
  }

  // void addToCart(CartModel _cartModel){
  //   _cartItems.add(_cartModel);
  //   notifyListeners();
  // }
  //
  // void removeFromCart(CartModel _cartModel){
  //   _cartItems.remove(_cartModel);
  //   notifyListeners();
  // }
}
