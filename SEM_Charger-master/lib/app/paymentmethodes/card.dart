import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:senior2023/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:senior2023/app/paymentmethodes/paysucsses.dart';
import 'package:senior2023/main.dart';

 bool? saved =sharedPref.getBool("saved");
class MySample extends StatefulWidget {
  final String fee;

  const MySample({Key? key, required this.fee}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MySampleState();
  }
}

class MySampleState extends State<MySample> {

  late String cardNumber = sharedPref.getString("card_num").toString();

  late String expiryDate = sharedPref.getString("exp_date").toString();
  late String cardHolderName = sharedPref.getString("holder_name").toString();
  late String cvvCode = sharedPref.getString("cvv").toString();
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  // bool saved=false;
  void checkcardnum(){
    if (saved==true) {
     //   print("saved = ");
      //  print(sharedPref.getBool("saved") as bool);
        cardNumber = sharedPref.getString("card_num").toString();
        expiryDate = sharedPref.getString("exp_date").toString();
        cardHolderName = sharedPref.getString("holder_name").toString();
        cvvCode = sharedPref.getString("cvv").toString();
      }else{
       // print("saved = ");
       // print(sharedPref.getBool("saved") as bool);
        cardNumber = '';
        expiryDate = '';
        cardHolderName = '';
        cvvCode = '';
        saved=false;
      }
  }

  void _saveCard() async {
    if (formKey.currentState!.validate()) {

      await sharedPref.setString("card_num", cardNumber);
      print("object");
      print(sharedPref.getString("card_num"));
      await sharedPref.setString("exp_date", expiryDate);
      await sharedPref.setString("cvv", cvvCode);
      await sharedPref.setString("holder_name", cardHolderName);
       saved = true;
      await sharedPref.setBool("saved", true);
      //print(sharedPref.getBool("saved"));
      print("card saved");
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        title: 'Success',
        desc: "Card saved successfuly",
        btnOkOnPress: () {

        },
        btnOkIcon: Icons.check,
        btnOkColor: Colors.greenAccent[400],
      //  btnCancelOnPress: () {},
    //    btnCancelColor: Colors.green,
      ).show();
    }
  }

  void _deleteCard() async {
   // print("saved = ");
    //print(sharedPref.getBool("saved") );
    if (saved==true) {
     // print("saved = ");
      //print(sharedPref.getBool("saved") );
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        title: 'Confirm',
        desc: "Do you want to delete your card details",
        btnOkOnPress: () {
          sharedPref.setString("card_num", '');
          sharedPref.setString("exp_date", '');
          sharedPref.setString("cvv", '');
          sharedPref.setString("holder_name", '');
           saved = false;
          sharedPref.setBool("saved", false);
          print("card deleted");
          setState(() {});
        },
        btnOkIcon: Icons.delete,
        btnOkColor: Colors.orange,
        btnCancelOnPress: () {},
        btnCancelColor: Colors.orange,
      ).show();
    } else {
      await AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'Error',
              desc: "No saved card found",
              btnOkOnPress: () {
                print("card not deleted");
                setState(() {});
              },
              btnOkText: "Cancel",
              btnOkColor: Colors.red)
          .show();
    }
  }

  @override
  void initState() {
    checkcardnum();
    border = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.orange,
        width: 1,
      ),
    );

    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Card View ',
      debugShowCheckedModeBanner: false,
      //   color: Colors.white,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Card Details"),
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('image/bg1.jpg'),
              fit: BoxFit.fill,
            ),
            color: Colors.white,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: CreditCardWidget(
                    glassmorphismConfig:
                        useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    bankName: 'Axis Bank',
                    frontCardBorder: !useGlassMorphism
                        ? Border.all(color: Colors.grey)
                        : null,
                    backCardBorder: !useGlassMorphism
                        ? Border.all(color: Colors.grey)
                        : null,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: AppColors.cardBgColor,
                    backgroundImage:
                        useBackgroundImage ? 'image/card_bg2.jpg' : null,
                    isSwipeGestureEnabled: false,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
                        cardImage: Image.asset(
                          'image/mastercard.png',
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    //  physics:ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.white,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                          onTap:(){AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            title: 'Confirm Payment',
                            desc: "Do you want to pay ${widget.fee} NIS ?",
                            btnOkOnPress: () {
                              _onValidate();
                            },
                            btnOkIcon: Icons.check_circle,
                            btnOkColor: Colors.orange,
                              btnCancelOnPress: () {},
                               btnCancelColor: Colors.orange,
                            btnCancelIcon: Icons.cancel
                          ).show();} ,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  AppColors.colorB58D67,
                                  AppColors.colorB58D67,
                                  AppColors.colorB58D67,
                                  AppColors.colorB58D67,
                                  AppColors.colorB58D67,
                                  AppColors.colorB58D67,
                                  AppColors.colorB58D67,
                                ],
                                begin: Alignment(-1, -4),
                                end: Alignment(1, 4),
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text(
                              'Confirm Payment',
                              style: TextStyle(
                                color: Color(0xff263a5b),
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //  crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MaterialButton(
                              color: Colors.blueGrey[100],
                              textColor: const Color(0xff263a5b),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              onPressed: () {
                                _saveCard();
                                const snackBar = SnackBar(
                                  content: Text(
                                    'Card saved',
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: const Text(
                                'Save Card',
                                style: TextStyle(
                                  color: Color(0xff263a5b),
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                  package: 'flutter_credit_card',
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.blueGrey[100],
                              textColor: const Color(0xff263a5b),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              onPressed: () {
                                _deleteCard();
                                const snackBar = SnackBar(
                                  content: Text('Card deleted'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: const Text(
                                'Delete Card',
                                style: TextStyle(
                                  color: Color(0xff263a5b),
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                  package: 'flutter_credit_card',
                                ),
                              ),
                            ),
                          ],
                        ),

                        InkWell(
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      //print('valid!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PaySuccess(fee: widget.fee)),
          (route) => false);
      // Navigator.of(context).pushNamedAndRemoveUntil(, (route) => false)
    } else {
      //print('invalid!');
      AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'Invalid Card Info.',
              desc: "Card information wrong or the card is expired",
              btnOkOnPress: () {},
              btnOkIcon: Icons.check,
              btnOkColor: Colors.red[900])
          .show();
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
