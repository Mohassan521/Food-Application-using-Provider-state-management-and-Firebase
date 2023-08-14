import 'package:flutter/material.dart';
import 'package:food_app/provider/my_provider.dart';
import 'package:food_app/screens/cart_page.dart';
import 'package:food_app/utils.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class DetailsPage extends StatefulWidget {

  final String image;
  final String name;
  final int price;
  final String catchphrase;

  const DetailsPage({super.key, required this.catchphrase ,required this.image, required this.name, required this.price});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {

    MyProvider provider = Provider.of<MyProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xff2b2b2b),
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)),
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
          Expanded(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(widget.image, width: double.infinity, height: 90, fit: BoxFit.cover,),
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
                    Text(
                      widget.name,
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    Text(
                      widget.catchphrase,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() => {
                              if(quantity == 1){
                                Utils.flushbarErrorMessage('quantity cannot be less than 1', context)
                              }
                              else if(quantity > 1){
                                quantity--,
                              }
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() => {
                              quantity++
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.add),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                        ),
                        Text(
                          "\$${widget.price * quantity}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        )
                      ],
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            provider.addToCart(
                                image: widget.image,
                                name: widget.name,
                                price: widget.price,
                                qty: quantity,
                                catchphrase: widget.catchphrase
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff2b2b2b)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.shopping_cart,
                                size: 30,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
