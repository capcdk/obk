import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookKeepingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 52),
            width: 152,
            height: 40,
            color: Colors.red,
          ),
          Container(
            margin: EdgeInsets.only(top: 68),
            width: 265,
            height: 60,
            color: Colors.blue,
          ),
          Container(
            margin: EdgeInsets.only(top: 140),
            height: 60,
            color: Colors.yellow,
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: 47,
            color: Colors.brown,
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              height: 47,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
