import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:senior2023/app/paymentmethodes/card.dart';
import 'package:senior2023/app/paymentmethodes/paypal.dart';
import 'package:flutter/material.dart';
import 'components/customtextform.dart';
import 'components/valid.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  // Curd _curd = Curd();
//  bool isLoading = false;
  TextEditingController fee = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff263a5b),
        ),
        title: const Text(
          "Payment Information",
          style: TextStyle(
            color: Color(0xff263a5b),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
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
            child: ListView(
              children: [
                Form(
                    key: _formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                              width: MediaQuery.of(context).size.width*0.5,
                          height: MediaQuery.of(context).size.width * 0.4,
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
                          icon: const Icon(Icons.money),
                          readonly: false,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            return validInput(val!, 1, 50);
                          },
                          hint: 'Fee',
                          label: 'Fee',
                          controller: fee,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                             Container(
                               width: MediaQuery.of(context).size.width,
                               child: Text(
                               "Enter your Credit Card Details",
                                style:
                                   Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
                                textAlign: TextAlign.center,
                            ),
                             ),

                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          color: Colors.blueGrey[100],
                          textColor: const Color(0xff263a5b),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          onPressed: () {
                            if (fee.text.isNotEmpty) {
                              if (int.parse(fee.text) < 1) {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: 'Error',
                                        desc:
                                            "The fee can't be less than 1 NIS ",
                                        btnOkOnPress: () {},
                                        btnOkIcon: Icons.cancel,
                                        btnOkColor: Colors.red)
                                    .show();
                              } else  {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MySample(
                                          fee: fee.text,
                                        )));
                              }
                            } else {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      title: 'Error',
                                      desc: "Enter the desired fee.",
                                      btnOkOnPress: () {},
                                      btnOkIcon: Icons.cancel,
                                      btnOkColor: Colors.red)
                                  .show();
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
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

