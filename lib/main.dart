import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///D:/code/github/obk/lib/page/book_keeping.dart';
import 'package:obk/utils/global_value.dart';

void main() {
//  debugPaintSizeEnabled = true;
//  debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //注册路由表
      routes: {"/": (context) => ObkHomePage(), "book_keeping": (context) => BookKeepingPage()},
    );
    return app;
  }
}

class ObkHomePage extends StatelessWidget {
  ObkHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Global.init(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 280),
            child: Text(
              '开始记账吧',
              style: TextStyle(fontSize: 70, color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.55, right: screenWidth * 0.08),
                width: Global.screenWidth * 0.32,
                height: Global.screenHeight * 0.07,
                child: OutlineButton(
                  child: Text("记收入", style: TextStyle(fontSize: 35)),
                  borderSide: new BorderSide(color: Colors.blue),
                  color: Colors.white,
                  textColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                  onPressed: () => Navigator.pushNamed(context, "book_keeping"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.55, left: screenWidth * 0.08),
                width: Global.screenWidth * 0.32,
                height: Global.screenHeight * 0.07,
                child: FlatButton(
                  child: Text("记支出", style: TextStyle(fontSize: 35)),
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                  onPressed: () => Navigator.pushNamed(context, "book_keeping"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
