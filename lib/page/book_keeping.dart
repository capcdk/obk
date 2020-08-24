import 'package:flutter/material.dart';
import 'package:obk/book_keeping/amout_keyboard.dart';
import 'package:obk/book_keeping/category_slide_picker.dart';

class BookKeepingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

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
          // 输入区
          Container(
            margin: EdgeInsets.only(top: 180),
            width: 400,
            height: 130,
            child: _amountTextField(),
          ),
          // 分类选择器
          Container(
            margin: EdgeInsets.only(top: 280),
            height: 120,
            child: CategorySlidePicker(),
          ),
          // 备注输入区
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 80,
            color: Colors.brown,
          ),
          // 金额键盘
          Expanded(
            child: AmountKeyboard(),
          )
        ],
      ),
    );
  }

  Widget _amountTextField() {
    return TextField(
      style: TextStyle(fontSize: 60),
      cursorWidth: 6,
      cursorColor: Colors.black,
      readOnly: true,
      showCursor: true,
      autofocus: true,
      maxLines: 1,
      decoration: InputDecoration(
          hintText: " 请输入金额",
          hintStyle: TextStyle(fontSize: 60, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          prefixText: "￥",
          prefixStyle: TextStyle(fontSize: 60, fontWeight: FontWeight.w600)),
    );
  }
}
