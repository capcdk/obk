import 'package:flutter/material.dart';

class AmountKeyboard extends StatelessWidget {
  final List<Widget> _icons = [
    _createTextAmountButton("7"),
    _createTextAmountButton("8"),
    _createTextAmountButton("9"),
    FlatButton(
        textColor: Colors.black,
        child: Text(_getTodayDate(), style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
        onPressed: () {}),
    _createTextAmountButton("4"),
    _createTextAmountButton("5"),
    _createTextAmountButton("6"),
    _createTextAmountButton("+"),
    _createTextAmountButton("1"),
    _createTextAmountButton("2"),
    _createTextAmountButton("3"),
    _createTextAmountButton("-"),
    _createTextAmountButton("."),
    _createTextAmountButton("0"),
    Icon(Icons.backspace, color: Colors.black, size: 45),
    FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text("确定", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
        onPressed: () {})
  ];

  static FlatButton _createTextAmountButton(String text) {
    return FlatButton(
        child: Text(text, style: TextStyle(fontSize: 45, color: Colors.black, fontWeight: FontWeight.w400)), onPressed: () {});
  }

  static String _getTodayDate() {
    var today = DateTime.now();
    return "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (context, constraints) {
//      context为父级上下文biggest
      // 获取组件在父组件所能设置的最大高度
      var availableHeight = constraints.maxHeight;
      // 获取父组件宽度
      var availableWidth = constraints.maxWidth;

      return GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: availableWidth / availableHeight //显示区域宽高相等
                  ),
          itemCount: 16,
          itemBuilder: (context, index) {
            return _icons[index];
          });
    });
  }
}
