import 'package:senior2023/app/auth/signup.dart';
import 'package:senior2023/app/auth/success.dart';
import 'package:senior2023/app/editprofile.dart';
import 'package:senior2023/app/payment.dart';
import 'package:senior2023/app/profile.dart';
import 'package:senior2023/app/readings.dart';
import 'package:flutter/material.dart';
import 'app/auth/login.dart';
import 'app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/intro.dart';

late final SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //A concrete binding for applications based on the Widgets framework.
  // This is the glue that binds the framework to the Flutter engine.
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Senior Project 1',
      //? = no // : = yes
      //check if user is logged in
      initialRoute: sharedPref.getString("u_id") == null ? "intro" : "home",
      routes: {
        "login": (context) => const Login(),
        "signup": (context) => const Signup(),
        "home": (context) => const Home(),
        "success": (context) => const Success(),
        "intro": (context) => const introScreen(),
        "payment": (context) => const Payment(),
        "profile": (context) => const Profile(),
        "readings": (context) => const Readings(),
        "editprofile": (context) => const EditProfile(),

      },
      home: const introScreen(),
    );
  }
}
