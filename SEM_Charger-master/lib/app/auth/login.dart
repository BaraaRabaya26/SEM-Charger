import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:senior2023/main.dart';
import 'package:senior2023/app/components/curd.dart';
import 'package:senior2023/app/components/customtextform.dart';
import 'package:senior2023/app/constants/linkapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../components/valid.dart';
import 'signup.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  // late String m_id;
  Curd curd = Curd();
  bool isLoading = false;

  login() async {
    if (_formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      //     int? m_id = sharedPref.getInt("m_id");
      var response = await curd.postRequest(linkLogin, {
        "username": username.text,
        "password": password.text,
        // "m_id": m_id,
      });
      isLoading = false;
      setState(() {});
      //   print("response" + response.toString());

      if (response["status"] == "sucsses") {
        //     print("1");
        //   print(response['status']);
        await sharedPref.setString("u_id", response["data"]["U_ID"].toString());
        // await sharedPref.setString("m_id", response["data"]["M_ID"]()).toString();
        await sharedPref.setInt(
            "m_id", int.parse(response["data"]["M_ID"].toString()));
        await sharedPref.setString(
            "username", response["data"]["USERNAME"].toString());
        await sharedPref.setString(
            "password", response["data"]["PASSWORD"].toString());
        await sharedPref.setString(
            "f_name", response["data"]["F_NAME"].toString());
        await sharedPref.setString(
            "l_name", response["data"]["L_NAME"].toString());
        await sharedPref.setString(
            "phone_num", response["data"]["PHONE_NUM"].toString());
        await sharedPref.setString("city", response["data"]["CITY"].toString());
        //    print("response" + response.toString());
        //   print( sharedPref.getString("f_name"));

        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            title: 'Error',
            desc:
            "Username or Password is incorrect or Account doesn't exsist.",
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      isLoading == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "image/bg1.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),child: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
        child: Center(
          child: ListView(
            children: [
              Form(
                  key: _formstate,
                  child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 700,
                        height: 300,
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
                          Icons.person,
                          color: Colors.white,
                        ),
                        readonly: false,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          return validInput(val!, 3, 50);
                        },
                        hint: 'username',
                        label: 'Username',
                        controller: username,
                      ),
                      CustTextFormSign(
                        readonly: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          return validInput(val!, 8, 100);
                        },
                        hint: 'password',
                        label: 'Password',
                        controller: password,
                        icon: Icon(
                          Icons.password,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: Colors.blueGrey[100],
                        textColor: Color(0xff263a5b),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        onPressed: () async {
                          await login();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontSize: 17),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("signup");
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      ),

      ///sssss
    );
  }
}
