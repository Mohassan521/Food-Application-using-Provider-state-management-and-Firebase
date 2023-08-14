import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/login_page.dart';
import 'package:food_app/screens/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool loading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();

  void validateEmail(String val){
    if(val.isEmpty){
      Utils.flushbarErrorMessage('Email field cannot be empty', context);
    }
    else if(!EmailValidator.validate(val, true)){
      Utils.flushbarErrorMessage('Email is invalid', context);
    }
  }

  Future sendData() async {
      try{
        final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        await FirebaseFirestore.instance.collection('user_Data').doc(credentials.user?.uid).set({
          'user_id' : credentials.user?.uid,
          'Name' : nameController.text.trim(),
          'Email' : emailController.text.trim(),
          'Password' : passwordController.text.trim(),
        });
      } on FirebaseAuthException catch (e) {
        if(e.code == 'weak-password'){
          // print('The password provided is too weak');
          Utils.flushbarErrorMessage('Password provided is too weak', context);
        } else if(e.code == 'email-already-in-use'){
          Utils.flushbarErrorMessage('This email is already in use', context);
        }
      }catch (e){
        Utils.flushbarErrorMessage(e.toString(), context);
      }
      setState(() {
        loading = false;
      });
  }

  void validation(){
    if(nameController.text.trim().isEmpty || nameController.text.trim() == null){
      Utils.flushbarErrorMessage('Name field cannot be empty', context);
    }
    else if(emailController.text.trim().isEmpty || emailController.text.trim() == null){
      Utils.flushbarErrorMessage('Email field cannot be empty', context);
    }
    else if(passwordController.text.isEmpty || passwordController.text == null){
      Utils.flushbarErrorMessage('Password field cannot be empty', context);
    }
    else if(cPasswordController.text.isEmpty || passwordController.text == null){
      Utils.flushbarErrorMessage('Password field cannot be empty', context);
    }
    else if(passwordController.text != cPasswordController.text){
      Utils.flushbarErrorMessage('Password and confirm password should match', context);
    }
    else{
      setState(() {
        loading = true;
      });
      sendData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            SizedBox(
              height: 20,
            ),
            Center(
              child:Text('SIGN UP', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 40)
                ,),
            ),
            SizedBox(
              height: 45,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextFormField(
              style: const TextStyle(color: Colors.white),
              obscureText: false,
              controller: nameController,
              decoration: InputDecoration(
              prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 12),
                child: Icon(Icons.person_3_outlined, color: Colors.white),
              ),
              hintText: 'Username',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      )
            ),
            SizedBox(
              height: 25,
            ),
            FractionallySizedBox(
                widthFactor: 0.8,
                child: TextFormField(
                    onChanged: (val){
                      validateEmail(val);
                    },
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    controller: emailController,
                    decoration: InputDecoration(
                    prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12),
                    child: Icon(Icons.alternate_email_rounded, color: Colors.white),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                    )
                  ),
                )
            ),
            SizedBox(
              height: 25,
            ),
            FractionallySizedBox(
                widthFactor: 0.8,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12),
                      child: Icon(Icons.lock_outline_sharp, color: Colors.white),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                )
            ),
            SizedBox(
              height: 25,
            ),
            FractionallySizedBox(
                widthFactor: 0.8,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  controller: cPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12),
                      child: Icon(Icons.lock_outline_sharp, color: Colors.white),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                )
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 60,
              width: 150,
              child: (loading == true) ? SizedBox(height: 100, width: 100, child: Center(child: CircularProgressIndicator())) : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                  onPressed: (){
                      validation();
                  },
                  child: Text('Submit', style: TextStyle(fontSize: 17),)
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Already have an account? ', style: TextStyle(color: Colors.white),),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: Text('Login', style: TextStyle(color: Colors.orange),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
