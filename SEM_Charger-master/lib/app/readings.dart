import 'package:senior2023/main.dart';
import 'package:senior2023/app/models/readmodel.dart';
import 'package:senior2023/app/viewreads.dart';
import 'package:senior2023/app/components/cardreading.dart';
import 'package:senior2023/app/components/curd.dart';
import 'package:senior2023/app/constants/linkapi.dart';
import 'package:flutter/material.dart';

class Readings extends StatefulWidget {
  const Readings({Key? key}) : super(key: key);

  @override
  State<Readings> createState() => _ReadingsState();
}

// with curd // to use curd methods without making a curd object.
class _ReadingsState extends State<Readings> with Curd {
  getReadings() async {
    var response = await postRequest(linkViewReading, {
      //map data
      "m_id": sharedPref.getInt("m_id").toString(),
    });
    if (response["status"] == "sucsses") {
      // print(response["data"]);
      return response;
    }

    //   } else
    return null;
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
          "Readings Records",
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
            //  colorFilter: ColorFilter.mode(Color(0xff263a5b), BlendMode.overlay) ,
            image: AssetImage(
              "image/bg1.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            //CardRead(onTap: (){}, title: "REC", content: "content"),
            FutureBuilder(
              future: getReadings(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  int count = snapshot.data["data"].length;
                  if (snapshot.data['status'] == 'fail') {
                    return const Center(
                      child: Text("No Readings Available"),
                    );
                  }
                  //future builder gets the data from the req fun and returns a widget
                  //that will use this data (here listview.builder)
                  //listview.builder builds a list of widgets in this case ReadCards

                  return ListView.builder(
                      itemCount: 15,
                      shrinkWrap: true,
                      //بخلي ال item يوخد بس المساحة الضرورية فقط بدون مساحة اضافية
                          physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        if (snapshot.data['data'][count - i - 1]['DATE'] !=
                            null) {
                          //  print("num of r");
                          // print(snapshot.data['data']);
                          return CardRead(
                            onTap: () {
                              String t =
                                  "Reading of ${snapshot.data['data'][count - i - 1]['DATE']}";
                              int r = int.parse(
                                  snapshot.data['data'][count - i - 1]['R_ID']);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ViewReads(r_id: r, t: t)));
                            },
                            readModel: ReadModel.fromJson(
                                snapshot.data['data'][count - i - 1]),
                            title:
                                "Reading ${count - i}", // snapshot length - card no
                            // content: "${snapshot.data['data'][i]['DATE']}"
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
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
          ],
        ),
      ),
    );
  }
}
