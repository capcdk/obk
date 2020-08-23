import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:obk/BookKeeping.dart';

void main() {
//  debugPaintSizeEnabled = true;
//  debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //注册路由表
      routes: {
//        "new_page":(context) => NewRoute()
        "/": (context) => ObkHomePage(),
        "book_keeping": (context) => BookKeepingPage()
      },
    );
  }
}

class ObkHomePage extends StatelessWidget {
  ObkHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.only(top: 800, right: 100),
                width: 190,
                height: 90,
                child: OutlineButton(
                  child: Text("记收入", style: TextStyle(fontSize: 30)),
                  borderSide: new BorderSide(color: Colors.blue),
                  color: Colors.white,
                  textColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                  onPressed: () => Navigator.pushNamed(context, "book_keeping"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 800, left: 100),
                width: 190,
                height: 90,
                child: FlatButton(
                  child: Text("记支出", style: TextStyle(fontSize: 30)),
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
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
