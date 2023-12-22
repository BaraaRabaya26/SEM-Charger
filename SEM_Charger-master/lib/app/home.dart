import 'package:senior2023/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff263a5b),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Color(0xff263a5b),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "image/bg1.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(


                    child: Column(
                      //Container(height: 20,),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70)),
                          padding: const EdgeInsets.symmetric(
                               vertical: 50),
                          color: const Color(0xff263a5b),
                          onPressed: () {
                            Navigator.of(context).pushNamed("payment");
                          },
                          textColor: Colors.white,

                          child:  Text(
                            'Payment',
                            style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),

                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 50),
                          color: const Color(0xff445974),
                          onPressed: () {
                            Navigator.of(context).pushNamed("readings");
                          },
                          textColor: Colors.white,
                          child:  Text(
                            'Readings',
                            style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white)
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70)),
                           padding: const EdgeInsets.symmetric(
                                vertical: 50),
                          color: const Color(0xffa6b2c0),
                          onPressed: () {
                            Navigator.of(context).pushNamed("profile");
                          },
                          textColor: Colors.white,
                          child:  Text(
                            'Profile',
                            style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
                          ),
                        ),
                      ],
                    ),


            ),
          ),
        ),
      ),
    );
  }
}
