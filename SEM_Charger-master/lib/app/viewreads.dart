import 'package:senior2023/app/components/customtextform2.dart';
import 'package:flutter/material.dart';
import 'components/curd.dart';
import 'constants/linkapi.dart';

class ViewReads extends StatelessWidget with Curd {


  late String power;
  late String voltage;
  late String ampere;
  late String fee;
  final int r_id;
  final String t;
  @override
  ViewReads({super.key, required this.r_id, required this.t});

  getReadings() async {
    //  print("start");
//var r= int.parse(r_id);
    // if(m_id != null) {
    //  print("2");
    var response = await postRequest(linkViewOneReading, {
      "r_id": r_id.toString(),
    });
    //  print(r_id);

    // print(response["status"]);
    if (response["status"] == "sucsses") {
      //     print("response" + response.toString());

      return response;
    }

    //   } else
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.purple[50],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff263a5b),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          t,
          style: const TextStyle(
            color: Color(0xff263a5b),
          ),
        ),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
          child: FutureBuilder(
            future: getReadings(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['status'] == 'fail') {
                  return const Center(
                    child: Text("No Readings Available"),
                  );
                }
                return ListView.builder(
                    //
                    itemCount: 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      power = snapshot.data['data']['POWER'].toString();
                      voltage = snapshot.data['data']['VOLTAGE'].toString();
                      ampere = snapshot.data['data']['AMPERE'].toString();

                      fee = snapshot.data['data']['FEE'].toString();
                      //     balance = snapshot.data['data']['BALANCE'].toString();
                      return ReadTable(power, voltage, ampere, fee);
                    });
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),

      //
      //
    );
  }
}

class ReadTable extends StatelessWidget {
  final String? p;
  final String? v;
  final String? a;
  final String? f;

  // final String? b;

  ReadTable(this.p, this.v, this.a, this.f, {Key? key}) : super(key: key);

  // TextEditingController power = TextEditingController();
  // TextEditingController voltage = TextEditingController();
  // TextEditingController ampere = TextEditingController();
  // TextEditingController fee = TextEditingController();
  // TextEditingController balance = TextEditingController();

  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          key: _formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              CustTextFormSign2(
                obscureText: false,
                keyboardType: TextInputType.number,
                validator: (val) {
                  return null;

                  //  return validInput(val!, 3, 50);
                },
                hint: 'Power',
                label: 'Power',
                //   controller: power,
                readonly: true,
                init: p.toString(),
              ),
              CustTextFormSign2(
                obscureText: false,
                keyboardType: TextInputType.number,
                validator: (val) {
                  return null;

                  // return validInput(val!, 3, 50);
                },
                hint: 'Voltage',
                label: 'Voltage',
                //    controller: voltage,
                readonly: true,
                init: v.toString(),
              ),
              CustTextFormSign2(
                obscureText: false,
                keyboardType: TextInputType.number,
                validator: (val) {
                  return null;

                  //  return validInput(val!, 10, 10);
                },
                hint: 'Ampere',
                label: 'Ampere',
                //    controller: ampere,
                readonly: true,
                init: a.toString(),
              ),
              CustTextFormSign2(
                obscureText: false,
                keyboardType: TextInputType.number,
                validator: (val) {
                  return null;

                  // return validInput(val!, 3, 50);
                },
                hint: 'Fee',
                label: 'Fee',
                //   controller: fee,
                readonly: true,
                init: (double.parse(f.toString())*0.7).toString(),
              ),
              // CustTextFormSign2(
              //   obscureText: false,
              //   keyboardType: TextInputType.number,
              //   validator: (val) {
              //     //  return validInput(val!, 1, 11);
              //   },
              //   hint: 'Balance',
              //   label: 'Balance',
              //   //    controller: balance,
              //   readonly: true,
              //   init: b.toString(),
              // ),
            ],
          )),
    );
  }
}
