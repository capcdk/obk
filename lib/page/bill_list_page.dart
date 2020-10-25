import 'package:flutter/material.dart';
import 'package:obk/utils/global_value.dart';

class BillListPage extends StatefulWidget {
  BillListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BillListPageState();
}

// 记账输入页
class _BillListPageState extends State<BillListPage> {
  double monthIncome = 0;
  double monthExpenses = 0;
  int selectYear = DateTime.now().year;
  int selectMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Global.screenWidth,
        height: (Global.screenHeight * 0.2) + Global.topPadding,
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Global.topPadding + Global.screenHeight * 0.02),
              width: Global.screenWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: SizedBox(
                      child: Text("快记账", style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Positioned(
                      right: Global.screenWidth * 0.03,
                      child: SizedBox(
                        width: Global.screenWidth * 0.11,
                        child: FlatButton(
                            onPressed: () => null,
                            child: Image(
                              image: AssetImage("asserts/images/menu.png"),
                              fit: BoxFit.fitWidth,
                            )),
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Global.screenHeight * 0.04),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: Global.screenWidth * 0.05),
                      child: _dataTextField("收入", monthIncome.toString()),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: Global.screenWidth * 0.05),
                        child: _dataTextField("支出", monthExpenses.toString()),
                      )),
                  Container(
                    height: Global.screenHeight * 0.0435,
                    alignment: Alignment.center,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: const Color.fromRGBO(114, 183, 255, 1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: _dataTextField(selectYear.toString() + "年", selectMonth.toString() + "月"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dataTextField(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 30, color: const Color.fromRGBO(177, 215, 255, 1), fontWeight: FontWeight.w400)),
        Container(
          margin: EdgeInsets.only(top: Global.screenHeight * 0.02),
          child: Text(data, style: TextStyle(fontSize: 37, color: Colors.white, fontWeight: FontWeight.w500)),
        )
      ],
    );
  }
}
