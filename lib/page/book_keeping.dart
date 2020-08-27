import 'package:flutter/material.dart';
import 'package:obk/book_keeping/amount_keyboard.dart';
import 'package:obk/book_keeping/category_slide_picker.dart';
import 'package:obk/utills/global_value.dart';

class BookKeepingPage extends StatefulWidget {
  BookKeepingPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookKeepingPageState();
}

// 记账输入页
class _BookKeepingPageState extends State<BookKeepingPage> {
  final TextEditingController _amountController = TextEditingController();

  void onAmountInput(String input) {
    if (input.isEmpty) {
      return;
    }

    var oldLength = _amountController.text.length;
    if (AmountKeyboard.CONFIRM == input) {
      // 计算金额
    } else if (AmountKeyboard.BACKSPACE == input) {
      // 退格
      if (oldLength > 0) {
        _amountController.text = _amountController.text.substring(0, oldLength - 1);
      }
    } else {
      // 追加显示
      _amountController.text += input;
    }
    var newLength = _amountController.text.length;
    if (newLength != oldLength) {
      _amountController.selection = new TextSelection(baseOffset: newLength, extentOffset: newLength);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TAB
          Container(
            margin: EdgeInsets.only(top: 200),
            width: 260,
            height: 70,
            color: Colors.red,
          ),
          // 金额输入区
          Container(
            margin: EdgeInsets.only(top: 180),
            width: 400,
            height: 130,
            child: DecoratedBox(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 4, color: Colors.grey[200]))),
                child: AmountTextField(_amountController)),
          ),
          // 分类选择器
          Container(
            margin: EdgeInsets.only(top: 280),
            height: 120,
            child: CategorySlidePicker(),
          ),
          // 备注输入区
          Container(
            margin: EdgeInsets.only(top: Global.screenHeight * 0.02),
            padding: EdgeInsets.only(left: Global.screenWidth * 0.05),
            height: Global.screenHeight * 0.06,
            color: const Color.fromRGBO(39, 144, 255, 0.08),
            child: Container(alignment: Alignment.centerLeft, child: _remarkTextField()),
          ),
          // 金额键盘
          Expanded(
            child: AmountKeyboard(onInput: onAmountInput),
          )
        ],
      ),
    );
  }

  /**
   * 备注输入区
   */
  Widget _remarkTextField() {
    return Row(children: [
      Text("备注：", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w100)),
      Expanded(
          child: TextField(
              style: TextStyle(fontSize: 28),
              cursorWidth: 3,
              maxLines: 1,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: "点击此处添加备注", hintStyle: TextStyle(fontSize: 28, color: Colors.grey))))
    ]);
  }
}

// 金额输入控件
class AmountTextField extends StatefulWidget {
  AmountTextField(this.textController, {Key key}) : super(key: key);

  final textController;

  @override
  State<StatefulWidget> createState() => _AmountTextFieldState(textController);
}

class _AmountTextFieldState extends State<AmountTextField> {
  _AmountTextFieldState(this.textController) : super();

  final textController;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("￥", style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600)),
      Expanded(
          child: TextField(
              controller: textController,
              style: TextStyle(fontSize: 60),
              cursorWidth: 6,
              cursorColor: Colors.black,
              readOnly: true,
              showCursor: true,
              autofocus: true,
              maxLines: 1,
              decoration:
                  InputDecoration(hintText: "请输入金额", hintStyle: TextStyle(fontSize: 60, color: Colors.grey), border: InputBorder.none)))
    ]);
  }
}
