import 'package:flutter/material.dart';
import 'package:obk/utils/global_value.dart';

class AmountKeyboard extends StatelessWidget {
  AmountKeyboard(this.amountNotEmpty, this.needCalculate, this.onInput) : super();

  static const String BACKSPACE = "backspace";
  static const String CONFIRM = "confirm";
  static const String PLUS = "+";
  static const String MINUS = "—";
  static const String COMMA = ".";

  final ValueChanged<String> onInput;
  final bool needCalculate;
  final bool amountNotEmpty;

  FlatButton _createTextAmountButton(String text) {
    return FlatButton(
        child: Text(text, style: TextStyle(fontSize: 50, color: Colors.black, fontWeight: FontWeight.w400)),
        onPressed: () => onInput(text));
  }

  String _getTodayDate() {
    var today = DateTime.now();
    return "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // context为父级上下文biggest
      // 获取组件在父组件所能设置的最大高度
      var availableHeight = constraints.maxHeight;
      // 获取父组件宽度
      var availableWidth = constraints.maxWidth;

      return GridView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: availableWidth / availableHeight //显示区域宽高相等
                ),
        children: [
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
          _createTextAmountButton(AmountKeyboard.PLUS),
          _createTextAmountButton("1"),
          _createTextAmountButton("2"),
          _createTextAmountButton("3"),
          _createTextAmountButton(AmountKeyboard.MINUS),
          _createTextAmountButton(AmountKeyboard.COMMA),
          _createTextAmountButton("0"),
          FlatButton(
              child: SizedBox(
                  width: Global.screenWidth * 0.12,
                  child: Image(
                    image: AssetImage("asserts/images/backspace.png"),
                    fit: BoxFit.fitWidth,
                  )),
              onPressed: () => onInput(AmountKeyboard.BACKSPACE)),
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: const Color.fromRGBO(192, 223, 255, 1),
              disabledTextColor: Colors.white,
              child: Text(needCalculate ? "计算" : "确定", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
              onPressed: amountNotEmpty ? () => onInput(AmountKeyboard.CONFIRM) : null)
        ],
      );
    });
  }
}
