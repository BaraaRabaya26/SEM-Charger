import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:senior2023/main.dart';
import 'package:senior2023/app/components/customtextform.dart';
import 'package:flutter/material.dart';

import 'components/curd.dart';
import 'components/valid.dart';
import 'constants/linkapi.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

//final user;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with Curd {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  // late TextEditingController username = TextEditingController(text: );
  TextEditingController password = TextEditingController(
    text: sharedPref.getString("password").toString(),
  );
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

//  TextEditingController vpassword = TextEditingController();
  // final Curd _curd = Curd();
  edit() async {
    if (_formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await postRequest(linkEditUser, {
        'f_name': firstname.text,
        'l_name': lastname.text,
        'phone_num': phone.text,
        'city': city.text,
        'm_id': meterid.text,
        'password': password.text,
        "u_id": sharedPref.getString("u_id").toString(),
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == 'sucsses') {
        await sharedPref.setInt("m_id", int.parse(meterid.text));
        await sharedPref.setString("password", password.text);
        await sharedPref.setString("f_name", firstname.text);
        await sharedPref.setString("l_name", lastname.text);
        await sharedPref.setString("phone_num", phone.text);
        await sharedPref.setString("city", city.text);
        setState(() {});
        Navigator.of(context).pushReplacementNamed("profile");
      } else {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                title: 'Warning',
                desc:
                    "No edited fields detected, edit one of the fields at least to save or press the Cancel button to cancel the process.",
                btnOkOnPress: () {},
                //  btnOkIcon: Icons.,
                btnOkColor: Colors.yellow[700])
            .show();
      }
    }
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
          "Edit Profile",
          style: TextStyle(
            color: Color(0xff263a5b),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
              //   margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: ListView(
                    children: [
                      Form(
                          key: _formstate,
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
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
                                readonly: false,
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
                                readonly: false,
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
                                readonly: false,
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
                                readonly: false,
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
                                readonly: false,
                              ),
                              // CustTextFormSign(
                              //     obscureText: false,
                              //     keyboardType: TextInputType.text,
                              //     validator: (val) {
                              //       return validInput(val!, 5, 50);
                              //     },
                              //     hint: 'Username',
                              //     label: 'Username',
                              //     controller: username, inti: sharedPref.getString("username").toString(),),
                              CustTextFormSign(
                                icon: const Icon(
                                  Icons.password,
                                  color: Colors.white,
                                ),
                                obscureText: false,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  return validInput(val!, 8, 100);
                                },
                                hint: 'Password',
                                label: 'Password',
                                controller: password,
                                readonly: false,
                              ),

                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(70)),
                                color: Colors.blueGrey[100],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                onPressed: () {
                                  edit();
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Color(0xff263a5b), fontSize: 20),
                                ),
                              ),
                              Container(
                                height: 10,
                              ),
                              InkWell(
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
