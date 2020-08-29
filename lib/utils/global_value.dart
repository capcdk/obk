import 'package:flutter/material.dart';

class Global {
  static BuildContext appContext;

  // 宽度
  static double screenWidth;

  // 高度
  static double screenHeight;

  static init(BuildContext context) {
    Global.appContext = context;
    var screenSize = MediaQuery.of(context).size;
    Global.screenWidth = screenSize.width;
    Global.screenHeight = screenSize.height;
  }
}
