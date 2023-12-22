import 'package:flutter/material.dart';

class introScreen extends StatelessWidget {
  const introScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

          body: SafeArea(
            child: Container(
              height:MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,//اجعل عرض ال container ملائم لعرض شاشة العرض
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "image/bg1.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child:
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //   crossAxisAlignment:CrossAxisAlignment.baseline ,
                        children: [
                          const Text(
                            'SEM Charger',
                            style: TextStyle(
                              color: Color(0xff263a5b),
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          //  SizedBox(height: 400,),
                          Container(
                           // width: MediaQuery.of(context).size.width/4,
                            height: MediaQuery.of(context).size.height*0.4,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "image/logo.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                            color: Colors.blueGrey[100],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xff263a5b),
                                fontSize: 30,

                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "login");
                            },
                            // textColor: Colors.white,
                            //    bgColor: Colors.purple,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                            color: Colors.blueGrey[100],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: const Text(
                              'SignUp',
                              style: TextStyle(
                                color: Color(0xff263a5b),
                                fontSize: 30,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "signup");
                            },
                          ),
                          // textColor: Colors.white,
                          //    bgColor: Colors.purple,
                        ],
                      ),
                    ),

            ),
          )),
      //routes: {"log": ((context) => loginScreen())},
    );
  }
}
