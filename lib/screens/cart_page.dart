import 'package:flutter/material.dart';
import 'package:food_app/provider/my_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});


  @override
  Widget build(BuildContext context) {

    MyProvider provider = Provider.of<MyProvider>(context);

    return Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          height: 65,
          color: const Color(0xff3a3e3e),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$'+provider.totalPrice().toString(), style: TextStyle(color: Colors.white, fontSize: 22),),
                ElevatedButton(onPressed: (){}, child: Text('Proceed to Pay', style: TextStyle(fontSize: 22),))
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xff2b2b2b),
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
                children: [
                  (provider.cartItems.isEmpty) ? Center(child: Text('Cart is Empty', style: TextStyle(color: Colors.white, fontSize: 20),)) : Expanded(
                    child: ListView.builder(
                        itemCount: provider.cartItems.length,
                        itemBuilder: (context, index){
                          provider.getDeleteIndex(index);
                          return Card(
                            color: Color(0xff3a3b3b),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image(
                                              height: 100,
                                              width: 100,
                                              image: NetworkImage(provider.cartItems[index].image)
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(provider.cartItems[index].name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),),

                                              Row(
                                                children: [
                                                  Text('Unit Price: '+'\$'+provider.cartItems[index].price.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  // Container(
                                                  //   child: IconButton(icon: Icon(Icons.remove_circle_outline, color: Colors.white,),
                                                  //     onPressed: (){
                                                  //       if(provider.cartItems[index].quantity > 1){
                                                  //         provider.cartItems[index].quantity--;
                                                  //       }
                                                  //     },
                                                  //   ),
                                                  // ),
                                                  Text('Quantity: '+provider.cartItems[index].quantity.toString(), style: TextStyle(color: Colors.white, fontSize: 15),),
                                                  // Container(
                                                  //   child: IconButton(icon: Icon(Icons.add_circle_outline, color: Colors.white,),
                                                  //     onPressed: (){
                                                  //       provider.cartItems[index].quantity++;
                                                  //     },
                                                  //   ),
                                                  // ),
                                                ],
                                              )

                                            ],
                                          )

                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(onPressed: (){
                                    provider.delete();
                                  }, icon: const Icon(Icons.delete, color: Colors.white, size: 30,))
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              )

    );
  }
}
