import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Paypal extends StatefulWidget {
  final String fee;

  Paypal({Key? key, required this.fee}) : super(key: key);

  late Set<Future<dynamic>> futureFee = Future.value(fee) as Set<Future>;

  @override
  State<Paypal> createState() => _PaypalState();
}

class _PaypalState extends State<Paypal> {
  String _loadHtml() {
    return r'''
   <html>
   <body onload="document.f.submit;">
   <form id="f" name="f" method="post" action="http://10.0.2.2:3000/pay">
   <input type="hidden" name="fee" value="$(widgt.fee)"/>
   </form>
   </body>
   </html>

   ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Paypal"),
        ),
        body: WebView(
          onPageFinished: (page) {
            if (page.contains('success')) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("paysucsess", (route) => false);
            }
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              Uri.dataFromString(_loadHtml(), mimeType: 'text/html').toString(),
          //     initialUrl: Uri.dataFromString("http://10.0.2.2:3000/pay").toString(),
        ));
  }
}
