import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/provider/my_provider.dart';
import 'package:food_app/screens/burger_categories.dart';
import 'package:food_app/screens/Burger_detail_page.dart';
import 'package:food_app/screens/cart_page.dart';
import 'package:food_app/screens/home_page.dart';
import 'package:food_app/screens/login_page.dart';
import 'package:food_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCvM4BCaG7muNMnkgMlDgNm9tMcYdxgCwI',
          appId: 'com.example.foodapp',
          messagingSenderId: '',
          projectId: 'foodapp-3b618',
          databaseURL: '',
          storageBucket: ''));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MyProvider()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // scaffoldBackgroundColor: const Color(0xff2b2b2b),
            appBarTheme: const AppBarTheme(color: Color(0xff2b2b2b))),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (index, snapshot){
              if(!snapshot.hasData){
                return LoginPage();
              }
              return HomePage();
            }

        ),
      ),
    );
  }
}
