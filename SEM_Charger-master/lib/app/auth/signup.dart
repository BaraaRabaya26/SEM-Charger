import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:senior2023/app/components/curd.dart';
import 'package:senior2023/app/components/customtextform.dart';
import 'package:senior2023/app/components/valid.dart';
import 'package:senior2023/app/constants/linkapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'login.dart';
import 'package:senior2023/app/constants/message.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  Curd _curd = Curd();
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController meterid = TextEditingController();
  TextEditingController vpassword = TextEditingController();

  signUp() async {
    // print("1");
    //print("2" + _formstate.currentState.toString());
    if (_formstate.currentState!.validate()) {
      //     print("3");
      isLoading = true;
      setState(() {});
      var response = await _curd.postRequest(linkSignUp, {
        'f_name': firstname.text,
        'l_name': lastname.text,
        'phone_num': phone.text,
        'city': city.text,
        'm_id': meterid.text,
        'username': username.text,
        'password': password.text,
      });
      isLoading = false;
      setState(() {});
      //if(response[''](null)=="<br />"){print(" called on null");}
      if (response['status'] == 'sucsses') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            title: 'Error',
            desc:
            "Username ,Phone number or Meter ID Incorrect or in use",
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
            .show();
        print("sign up fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Container(
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
          padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
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
                          width: 500,
                          height: 200,
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
                          icon: Icon(Icons.abc,color: Colors.white,),
                          readonly: false,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            return validInput(val!, 3, 50);
                          },
                          hint: 'First name',
                          label: 'First name',
                          controller: firstname,
                        ),
                        CustTextFormSign(
                          icon: Icon(Icons.abc,color: Colors.white,),
                          readonly: false,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            return validInput(val!, 3, 50);
                          },
                          hint: 'Last name',
                          label: 'Last name',
                          controller: lastname,
                        ),
                        CustTextFormSign(
                          icon: Icon(Icons.phone,color: Colors.white,),
                          readonly: false,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            return validInput(val!, 10, 10);
                          },
                          hint: 'Phone number',
                          label: 'Phone number',
                          controller: phone,
                        ),
                        CustTextFormSign(
                          icon: Icon(Icons.location_city,color: Colors.white,),
                          readonly: false,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            return validInput(val!, 3, 50);
                          },
                          hint: 'City',
                          label: 'City',
                          controller: city,
                        ),
                        CustTextFormSign(
                          icon: Icon(Icons.electric_meter,color: Colors.white,),
                          readonly: false,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            return validInput(val!, 1, 11);
                          },
                          hint: 'Meter ID',
                          label: 'Meter ID',
                          controller: meterid,
                        ),
                        CustTextFormSign(
                          icon: Icon(Icons.person,color: Colors.white,),
                          readonly: false,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            return validInput(val!, 5, 50);
                          },
                          hint: 'Username',
                          label: 'Username',
                          controller: username,
                        ),
                        CustTextFormSign(
                          icon: Icon(Icons.password,color: Colors.white,),
                          readonly: false,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            return validInput(val!, 8, 100);
                          },
                          hint: 'Password',
                          label: 'Password',
                          controller: password,
                        ),
                        CustTextFormSign(
                          icon: Icon(Icons.password,color: Colors.white,),
                          readonly: false,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val != password.text)
                              return "password doesn't match";
                            return validInput(val!, 8, 100);
                          },
                          hint: 'Verify Password',
                          label: 'Verify Password',
                          controller: vpassword,
                        ),
                        MaterialButton(
                          color: Colors.blueGrey[100],
                          textColor: Color(0xff263a5b),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          onPressed: () async {
                            await signUp();
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white, fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed("login");
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
