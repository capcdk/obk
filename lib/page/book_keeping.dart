import 'dart:math';

import 'package:flutter/material.dart';
import 'package:obk/book_keeping/amount_keyboard.dart';
import 'package:obk/book_keeping/category_slide_picker.dart';
import 'package:obk/utils/global_value.dart';
import 'package:obk/utils/toast_utils.dart';

class BookKeepingPage extends StatefulWidget {
  BookKeepingPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookKeepingPageState();
}

// 记账输入页
class _BookKeepingPageState extends State<BookKeepingPage> {
  final TextEditingController _amountController = TextEditingController();
  bool needCalculate = false;
  bool amountNotEmpty = false;
  bool chooseIncome = false;

  void onAmountInput(String input) {
    if (input.isEmpty) {
      return;
    }

    var oldText = _amountController.text;
    var oldLength = oldText.length;
    bool textChange = false;
    if (AmountKeyboard.CONFIRM == input) {
      if (oldLength > 0) {
        if (needCalculate) {
          // 计算金额
          List<double> nums = new List();
          String num = "";
          double positive = 1;
          for (var value in oldText.characters) {
            if (AmountKeyboard.PLUS == value) {
              nums.add(positive * double.parse(num));
              num = "";
              positive = 1;
            } else if (AmountKeyboard.MINUS == value) {
              nums.add(positive * double.parse(num));
              num = "";
              positive = -1;
            } else {
              num += value;
            }
          }
          if (num.isNotEmpty) {
            nums.add(positive * double.parse(num));
          }
          if (nums.isNotEmpty) {
            double result = 0;
            nums.forEach((e) => result += e);
            _amountController.text = double2StandardAmount(result);
            textChange = true;
          }
        } else {
          // TODO 添加账单
          double amount = double.parse(oldText);
          if (amount < 0) {
            ToastUtils.showBasicToast("账单不支持记录负数");
          } else {
            _amountController.text = str2StandardAmount(oldText);
            // 游标置最后
            _amountController.selection =
                new TextSelection(baseOffset: _amountController.text.length, extentOffset: _amountController.text.length);
            return;
          }
        }
      }
    } else if (AmountKeyboard.BACKSPACE == input) {
      // 退格
      if (oldLength > 0) {
        _amountController.text = oldText.substring(0, oldLength - 1);
        textChange = true;
      }
    } else {
      if (isSpecialSign(input) &&
          (oldLength == 0 ||
              isSpecialSign(oldText.substring(oldLength - 1, oldLength)) ||
              (AmountKeyboard.COMMA == input && isConsequentComma(oldText)))) {
        // 错误提示
        ToastUtils.showBasicToast("请按正确格式输入");
      } else {
        // 追加显示
        _amountController.text += input;
        textChange = true;
      }
    }
    var newLength = _amountController.text.length;
    if (textChange) {
      // 游标置最后
      _amountController.selection = new TextSelection(baseOffset: newLength, extentOffset: newLength);
      // 更新键盘区样式
      var newAmountNotEmpty = newLength > 0;
      var newNeedCalculate = _amountController.text.contains(AmountKeyboard.PLUS) || _amountController.text.contains(AmountKeyboard.MINUS);
      if (newNeedCalculate != this.needCalculate || newAmountNotEmpty != this.amountNotEmpty) {
        setState(() {
          this.needCalculate = newNeedCalculate;
          this.amountNotEmpty = newAmountNotEmpty;
        });
      }
    }
  }

  void onBillTypeChange(bool chooseIncome) {
    this.chooseIncome = chooseIncome;
  }

  String double2StandardAmount(double input) => str2StandardAmount(input.toString());

  String str2StandardAmount(String input) {
    var commaIndex = input.lastIndexOf(AmountKeyboard.COMMA);
    if (commaIndex > 0) {
      return input.substring(0, min(input.length, commaIndex + 3));
    }
    return input;
  }

  /// 是否距离最近一个逗点之间无其他符号
  bool isConsequentComma(String input) {
    var lastCommaIndex = input.lastIndexOf(AmountKeyboard.COMMA);
    return lastCommaIndex >= 0 &&
        input.indexOf(AmountKeyboard.PLUS, lastCommaIndex) < 0 &&
        input.indexOf(AmountKeyboard.MINUS, lastCommaIndex) < 0;
  }

  bool isCalSign(String input) => AmountKeyboard.MINUS == input || AmountKeyboard.PLUS == input;

  bool isSpecialSign(String input) => AmountKeyboard.MINUS == input || AmountKeyboard.PLUS == input || AmountKeyboard.COMMA == input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TAB
          BillTypeChooser(onBillTypeChange),
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
          Expanded(child: AmountKeyboard(amountNotEmpty, needCalculate, onAmountInput))
        ],
      ),
    );
  }

  /// 备注输入区
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

class BillTypeChooser extends StatefulWidget {
  BillTypeChooser(this.onBillTypeChange, {Key key}) : super(key: key);
  ValueChanged<bool> onBillTypeChange;

  @override
  State<StatefulWidget> createState() => _BillTypeChooserState((onBillTypeChange));
}

// 账单模式切换
class _BillTypeChooserState extends State<BillTypeChooser> {
  _BillTypeChooserState(this.onBillTypeChange);

  ValueChanged<bool> onBillTypeChange;
  bool chooseIncome = false;

  @override
  Widget build(BuildContext context) {
    double borderWidth = 2;
    var tabWidth = Global.screenWidth * 0.208;
    var tabHeight = Global.screenWidth * 0.4053 * 0.263;
    var baseWidth = tabWidth * 2 + borderWidth * 2;
    var baseHeight = tabHeight + borderWidth * 2;
    return Container(
      margin: EdgeInsets.only(top: Global.screenHeight * 0.10),
      width: baseWidth,
      height: baseHeight,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(43, 146, 255, 0.3), width: borderWidth),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: Stack(
//        overflow: Overflow.visible,
        children: [
          AnimatedPositioned(
              left: chooseIncome ? tabWidth : 0,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              child: Container(
                width: tabWidth,
                height: tabHeight,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(60.0)),
              )),
          Positioned(
              left: 0,
              child: SizedBox(
                width: tabWidth,
                height: tabHeight,
                child: _createBillTypeButton(false),
              )),
          Positioned(
              left: tabWidth,
              child: SizedBox(
                width: tabWidth,
                height: tabHeight,
                child: _createBillTypeButton(true),
              )),
        ],
      ),
    );
  }

  Widget _createBillTypeButton(bool incomeButton) {
    return FlatButton(
      child: Text(incomeButton ? "收入" : "支出", style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
      color: Colors.transparent,
      textColor: (incomeButton == chooseIncome) ? Colors.white : Colors.black,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0), side: BorderSide(color: Colors.yellow, width: 3)),
      onPressed: () {
        setState(() {
          this.chooseIncome = incomeButton;
        });
        onBillTypeChange(chooseIncome);
      },
    );
  }
}

// 金额输入控件
class AmountTextField extends StatelessWidget {
  AmountTextField(this.textController, {Key key}) : super(key: key);

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
