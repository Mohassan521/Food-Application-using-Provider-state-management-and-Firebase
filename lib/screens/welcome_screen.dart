import 'package:flutter/material.dart';
import 'package:food_app/screens/login_page.dart';
import 'package:food_app/screens/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Container(
                   child: Center(
                     child: Image.asset('images/logo.png'),
                   ),
                )
            ),
            Expanded(
                child: Container(
                  child: Column(
                    children:  [
                      Text('Welcome to Bhook Junction', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.orange
                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text('ORDER, EAT, REPEAT', style: TextStyle(fontSize: 15),),
                      const SizedBox(
                        height: 28,
                      ),
                      Container(
                        height: 60,
                        width: 250,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                              )
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                            },
                            child: const Text('Login', style: TextStyle(fontSize: 17),)
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: 250,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                ),

                                side: BorderSide(width: 3, color: Colors.orange)
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                            },
                            child: const Text('Sign Up', style: TextStyle(color: Colors.orange, fontSize: 17),)
                        ),
                      )
                    ],
                    
                  ),
                )
            ),
          ],
        ),
    );
  }
}
