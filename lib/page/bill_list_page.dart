import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:obk/icons/my_icons.dart';
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
        body: Column(
      children: [
        Container(
          width: Global.screenWidth,
          height: (Global.screenHeight * 0.2) + Global.topPadding,
          color: Colors.blue,
          child: Column(
            children: [
              // 标题、菜单按钮
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
              // 月收入、支出
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(selectYear.toString() + "年",
                              style: TextStyle(fontSize: 30, color: const Color.fromRGBO(177, 215, 255, 1), fontWeight: FontWeight.w400)),
                          Container(
                            margin: EdgeInsets.only(top: Global.screenHeight * 0.02),
                            child: FlatButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(selectMonth.toString() + "月",
                                      style: TextStyle(fontSize: 33, color: Colors.white, fontWeight: FontWeight.w500)),
                                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 40)
                                ],
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Global.screenHeight * 0.17),
          width: Global.screenWidth * 0.56,
          child: Image(
            image: AssetImage("asserts/images/bill_list_blank.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          child: Text(
            "暂无数据",
            style: TextStyle(fontSize: 32, color: const Color.fromRGBO(170, 170, 170, 1)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Global.screenHeight * 0.2),
          width: Global.screenWidth * 0.19,
          height: Global.screenWidth * 0.19,
          child: RaisedButton(
            color: const Color.fromRGBO(43, 146, 255, 1),
            elevation: 4,
            child: Icon(
              MyIcons.add,
              color: Colors.white,
              size: 60,
            ),
            shape: CircleBorder(),
            onPressed: () {},
          ),
        )
      ],
    ));
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
