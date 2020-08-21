import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:obk/BookKeeping.dart';

void main() {
  debugPaintSizeEnabled = true;
  debugPaintPointersEnabled = true;
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
      body: Stack(
        children: [
          Positioned(
            top: 130,
            left: 113,
            child: Text(
              '开始记账吧',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
            left: 38,
            bottom: 60,
            height: 56,
            width: 120,
            child: OutlineButton(
              child: Text("记收入"),
              borderSide: new BorderSide(color: Colors.blue),
              color: Colors.white,
              textColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0)),
              onPressed: () => Navigator.pushNamed(context, "book_keeping"),
            ),
          ),
          Positioned(
            right: 38,
            bottom: 60,
            height: 56,
            width: 120,
            child: FlatButton(
              child: Text("记支出"),
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0)),
              onPressed: () => Navigator.pushNamed(context, "book_keeping"),
            ),
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
