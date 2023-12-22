import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class PaySuccess extends StatefulWidget {
  final String fee;

  const PaySuccess({Key? key, required this.fee}) : super(key: key);

  @override
  State<PaySuccess> createState() => _PaySuccessState();
}

class _PaySuccessState extends State<PaySuccess> {
  double price = 0.7; // price of 1KWh

  ValueNotifier<dynamic> result =
      ValueNotifier("Bring your phone near the meter");
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }
  // String result = "Bring your phone near the meter";

  // setState(() {});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(

        onWillPop: _onWillPop,
        child: Scaffold(
          //  appBar: AppBar(title: Text('NfcManager Plugin Example')),
          body: Container(
            padding: const EdgeInsets.all(30.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                //  colorFilter: ColorFilter.mode(Color(0xff263a5b), BlendMode.overlay) ,
                image: AssetImage(
                  "image/bg1.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(30.0),
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
                child: FutureBuilder<bool>(
                  future: NfcManager.instance.isAvailable(),
                  builder: (context, ss) => ss.data != true
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'NFC is not enabled, or your device does not support NFC',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff263a5b),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600),
                            ),
                                SizedBox(height: 20,),
                            MaterialButton(
                              color: Colors.blueGrey[100],
                              textColor: const Color(0xff263a5b),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 10),
                              onPressed: () {
                                setState(() {});
                              },
                              child: const Text(
                                'Refresh',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "image/nfc.png",
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ))
                      : Flex(
                          mainAxisAlignment: MainAxisAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            Flexible(
                              flex: 1,
                              //  child: Container(

                              child: SingleChildScrollView(
                                child: ValueListenableBuilder<dynamic>(
                                  valueListenable: result,
                                  builder: (context, value, _) => Text(
                                    '${value ?? ''}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff263a5b),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              //  ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ElevatedButton(
                                  //     //style:ButtonStyle(),
                                  //     onPressed: _ndefWrite,
                                  //     //style:ButtonStyle(),
                                  //     child: const Text('Charge')),
                                  MaterialButton(
                                    color: Colors.blueGrey[100],
                                    textColor: const Color(0xff263a5b),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(70)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 70, vertical: 10),
                                    onPressed:
                                      _ndefWrite //_ means private
                                   ,
                                    child: Text(
                                      'Charge',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "image/nfc.png",
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 10,),
                                  // MaterialButton(
                                  //   color: Colors.blueGrey[100],
                                  //   textColor: const Color(0xff263a5b),
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(70)),
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 70, vertical: 10),
                                  //   onPressed: () {
                                  //     // setState(() {});
                                  //     _tagRead;
                                  //   },
                                  //   child: Text(
                                  //     'Read tag info',
                                  //     style: TextStyle(fontSize: 20),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////
//   void _tagRead() {
//     setState(() {});
//     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
//       //  result.value = tag.data;
//       NfcManager.instance.stopSession();
//     });
//   }

//////////////////////////////////////////////////////////////////////////////////////////////
  void _ndefWrite() {
    setState(() {}); // to check that ncf in on during charging process (pressed on charge button)
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';

        NfcManager.instance.stopSession(errorMessage: result.value);

        return;
      }
      double c = (int.parse(widget.fee) / price);

      NdefMessage message = NdefMessage([
        NdefRecord.createText("charged :${c.toStringAsFixed(3)}KWh"),

      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';

        NfcManager.instance.stopSession();
        AwesomeDialog(
          // منعنا الضغط على بقية الشاشة، فقط على  الOK Button حتى ما يرجع ع صفحة الnfc و يقدر يعمل عملية شحن(لمنع السرقة و الاحتيال)
                context: context,
                dialogType: DialogType.success,
                title: 'Charge Successful.',
                desc: "You will be redirected to the home page.",
            dismissOnTouchOutside:false,
                btnOkOnPress: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("home", (route) => false);
                  // remove cache memory to prevent back to payment pages
                },
                btnOkIcon: Icons.check,
                btnOkColor: Colors.greenAccent[400])
            .show();

      } catch (e) {
        result.value = "Try Again if it doesn't work then nfc not compatible";

        NfcManager.instance.stopSession(errorMessage: result.value.toString());

        return;
      }
    });
  }
}
