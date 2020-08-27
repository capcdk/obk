import 'package:flutter/material.dart';
import 'package:obk/utills/global_value.dart';

class AmountKeyboard extends StatefulWidget {
  AmountKeyboard({Key key, @required this.onInput}) : super(key: key);

  static const String BACKSPACE = "backspace";
  static const String CONFIRM = "confirm";

  final ValueChanged<String> onInput;

  @override
  State<StatefulWidget> createState() => _AmountKeyboardState(onInput);
}

class _AmountKeyboardState extends State<AmountKeyboard> {
  _AmountKeyboardState(this.onInput) : super();

  final ValueChanged<String> onInput;

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
          _createTextAmountButton("+"),
          _createTextAmountButton("1"),
          _createTextAmountButton("2"),
          _createTextAmountButton("3"),
          _createTextAmountButton("—"),
          _createTextAmountButton("."),
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
              child: Text("确定", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
              onPressed: () => onInput(AmountKeyboard.CONFIRM))
        ],
      );
    });
  }
}
