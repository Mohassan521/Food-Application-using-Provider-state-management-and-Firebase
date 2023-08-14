import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/home_page.dart';
import 'package:food_app/screens/sign_up.dart';
import 'package:food_app/screens/welcome_screen.dart';
import 'package:food_app/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future Login() async {
    try {
      final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
    }
    on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        Utils.flushbarErrorMessage('User not found with this email', context);
      }
      else if(e.code == 'wrong-password'){
        Utils.flushbarErrorMessage('Invalid Email or Password', context);
      }
    }
    catch(e){
      Utils.flushbarErrorMessage(e.toString(), context);
    }
    setState(() {
      loading = false;
    });
  }

  void validation(){
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      Utils.flushbarErrorMessage('None fields can be left empty', context);
    }
    else{
      setState(() {
        loading = true;
      });
      Login();
    }
  }

  Widget TextField(
      {required String hintText,
        required TextEditingController controller,
      required IconData icon,
      required Color iconColor,
      required bool obs}) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      obscureText: obs,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 12),
          child: Icon(icon, color: iconColor),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
              Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            SizedBox(
              height: 60,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                  obs: false,
                  controller: emailController,
                  iconColor: Colors.white,
                  icon: Icons.alternate_email_rounded,
                  hintText: "Email"),
            ),
            SizedBox(
              height: 30,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                  obs: true,
                  controller: passwordController,
                  iconColor: Colors.white,
                  icon: Icons.lock_outline_rounded,
                  hintText: "Password"),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 60,
              width: 150,
              child: loading == true ? const SizedBox(height: 100, width: 100, child: Center(child: CircularProgressIndicator())) : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    validation();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 17),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dont have an account? ',
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.orange),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
