import 'package:senior2023/main.dart';
import 'package:flutter/material.dart';
import 'components/customtextform.dart';
import 'components/valid.dart';
import 'package:senior2023/app/components/curd.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with Curd {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  bool isLoading = false;
  TextEditingController password =
  TextEditingController(text: sharedPref.getString("password").toString(),);
  TextEditingController firstname = TextEditingController(
    text: sharedPref.getString("f_name").toString(),
  );
  TextEditingController lastname = TextEditingController(
    text: sharedPref.getString("l_name").toString(),
  );
  TextEditingController phone = TextEditingController(
    text: sharedPref.getString("phone_num").toString(),
  );
  TextEditingController city = TextEditingController(
    text: sharedPref.getString("city").toString(),
  );
  TextEditingController meterid = TextEditingController(
    text: sharedPref.getInt("m_id").toString(),
  );

  String pass = '';
@override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff263a5b),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xff263a5b),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body:  SafeArea(

          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                //  colorFilter: ColorFilter.mode(Color(0xff263a5b), BlendMode.overlay) ,
                image: AssetImage(
                  "image/bg1.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                      key: _formstate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                           // width: MediaQuery.of(context).size.width/4,
                            height: MediaQuery.of(context).size.width*0.4,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "image/logo.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CustTextFormSign(
                            icon: const Icon(
                              Icons.abc,
                              color: Colors.white,
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              return validInput(val!, 3, 50);
                            },
                            hint: 'First name',
                            label: 'First name',
                            controller: firstname,
                            readonly: true,
                          ),
                          CustTextFormSign(
                            icon: const Icon(
                              Icons.abc,
                              color: Colors.white,
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              return validInput(val!, 3, 50);
                            },
                            hint: 'Last name',
                            label: 'Last name',
                            controller: lastname,
                            readonly: true,
                          ),
                          CustTextFormSign(
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              return validInput(val!, 10, 10);
                            },
                            hint: 'Phone number',
                            label: 'Phone number',
                            controller: phone,
                            readonly: true,
                          ),
                          CustTextFormSign(
                            icon: const Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              return validInput(val!, 3, 50);
                            },
                            hint: 'City',
                            label: 'City',
                            controller: city,
                            readonly: true,
                          ),
                          CustTextFormSign(
                            icon: const Icon(
                              Icons.electric_meter,
                              color: Colors.white,
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              return validInput(val!, 1, 11);
                            },
                            hint: 'Meter ID',
                            label: 'Meter ID',
                            controller: meterid,
                            readonly: true,
                          ),
                          // CustTextFormSign(
                          //     obscureText: false,
                          //     keyboardType: TextInputType.text,
                          //     validator: (val) {
                          //       return validInput(val!, 5, 50);
                          //     },
                          //     hint: 'Username',
                          //     label: 'Username',
                          //     controller: u
                          //     icon: Icon(Icons.password),sername, inti: sharedPref.getString("username").toString(),),
                          CustTextFormSign(
                            icon: const Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val) {
                              return validInput(val!, 8, 100);
                            },
                            hint: 'Password',
                            label: 'Password',
                            controller: password,
                            readonly: true,
                          ),
                         // SizedBox(height: 10,)
                        ],
                      )),

                )
              ],
            ),
          ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("editprofile");
        },
        backgroundColor: Colors.blueGrey[100],
        child: const Icon(
          Icons.edit,
          color: Color(0xff263a5b),
        ),
      ),
    );
  }
}
//
// class ProfileView extends StatelessWidget {
//   // const ProfileView({Key? key}) : super(key: key);
//
//   final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
//
//   bool isLoading = false;
//   TextEditingController password =
//       TextEditingController(text: );
//   TextEditingController firstname = TextEditingController(
//     text: sharedPref.getString("f_name").toString(),
//   );
//   TextEditingController lastname = TextEditingController(
//     text: sharedPref.getString("l_name").toString(),
//   );
//   TextEditingController phone = TextEditingController(
//     text: sharedPref.getString("phone_num").toString(),
//   );
//   TextEditingController city = TextEditingController(
//     text: sharedPref.getString("city").toString(),
//   );
//   TextEditingController meterid = TextEditingController(
//     text: sharedPref.getInt("m_id").toString(),
//   );
//
//   String pass = '';
//
//   ProfileView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             //  colorFilter: ColorFilter.mode(Color(0xff263a5b), BlendMode.overlay) ,
//             image: AssetImage(
//               "image/bg1.jpg",
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
//               child: Form(
//                   key: _formstate,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 700,
//                         height: 200,
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(
//                               "image/logo.png",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       CustTextFormSign(
//                         icon: const Icon(
//                           Icons.abc,
//                           color: Colors.white,
//                         ),
//                         obscureText: false,
//                         keyboardType: TextInputType.name,
//                         validator: (val) {
//                           return validInput(val!, 3, 50);
//                         },
//                         hint: 'First name',
//                         label: 'First name',
//                         controller: firstname,
//                         readonly: true,
//                       ),
//                       CustTextFormSign(
//                         icon: const Icon(
//                           Icons.abc,
//                           color: Colors.white,
//                         ),
//                         obscureText: false,
//                         keyboardType: TextInputType.name,
//                         validator: (val) {
//                           return validInput(val!, 3, 50);
//                         },
//                         hint: 'Last name',
//                         label: 'Last name',
//                         controller: lastname,
//                         readonly: true,
//                       ),
//                       CustTextFormSign(
//                         icon: const Icon(
//                           Icons.phone,
//                           color: Colors.white,
//                         ),
//                         obscureText: false,
//                         keyboardType: TextInputType.phone,
//                         validator: (val) {
//                           return validInput(val!, 10, 10);
//                         },
//                         hint: 'Phone number',
//                         label: 'Phone number',
//                         controller: phone,
//                         readonly: true,
//                       ),
//                       CustTextFormSign(
//                         icon: const Icon(
//                           Icons.location_city,
//                           color: Colors.white,
//                         ),
//                         obscureText: false,
//                         keyboardType: TextInputType.text,
//                         validator: (val) {
//                           return validInput(val!, 3, 50);
//                         },
//                         hint: 'City',
//                         label: 'City',
//                         controller: city,
//                         readonly: true,
//                       ),
//                       CustTextFormSign(
//                         icon: const Icon(
//                           Icons.electric_meter,
//                           color: Colors.white,
//                         ),
//                         obscureText: false,
//                         keyboardType: TextInputType.number,
//                         validator: (val) {
//                           return validInput(val!, 1, 11);
//                         },
//                         hint: 'Meter ID',
//                         label: 'Meter ID',
//                         controller: meterid,
//                         readonly: true,
//                       ),
//                       // CustTextFormSign(
//                       //     obscureText: false,
//                       //     keyboardType: TextInputType.text,
//                       //     validator: (val) {
//                       //       return validInput(val!, 5, 50);
//                       //     },
//                       //     hint: 'Username',
//                       //     label: 'Username',
//                       //     controller: u
//                       //     icon: Icon(Icons.password),sername, inti: sharedPref.getString("username").toString(),),
//                       CustTextFormSign(
//                         icon: const Icon(
//                           Icons.password,
//                           color: Colors.white,
//                         ),
//                         obscureText: true,
//                         keyboardType: TextInputType.visiblePassword,
//                         validator: (val) {
//                           return validInput(val!, 8, 100);
//                         },
//                         hint: 'Password',
//                         label: 'Password',
//                         controller: password,
//                         readonly: true,
//                       ),
//                     ],
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
