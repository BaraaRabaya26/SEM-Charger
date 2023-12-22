import 'package:senior2023/app/models/readmodel.dart';
import 'package:flutter/material.dart';

class CardRead extends StatelessWidget {
  final void Function()? onTap;
  final String title;

//  final String content;
  final ReadModel readModel;

  const CardRead({
    Key? key,
    required this.onTap,
    required this.readModel,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Color.fromRGBO(38, 58, 91, 200),
        shadowColor: Color(0xff8a9aaa),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.list,
                size: 100,
                color: Colors.orange[600],
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(color: Colors.orange[50], fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  "${readModel.dATE}",
                  style: TextStyle(color: Colors.orange[100], fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
