import 'package:flutter/material.dart';

class CartModel{
  final String image;
  final String name;
  final int price;
  final String catchphrase;
  late final int quantity;

  CartModel({required this.image,
    required this.name,
    required this.price,
    required this.catchphrase,
    required this.quantity
  });

}