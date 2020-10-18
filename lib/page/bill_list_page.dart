import 'package:flutter/material.dart';
import 'package:obk/utils/global_value.dart';

class BillListPage extends StatefulWidget {
  BillListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BillListPageState();
}

// 记账输入页
class _BillListPageState extends State<BillListPage> {
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
                      child: Text("快记账", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Positioned(
                      right: Global.screenWidth * 0.03,
                      child: SizedBox(
                        width: Global.screenWidth * 0.12,
                        child: FlatButton(
                            onPressed: () => null,
                            child: Image(
                              image: AssetImage("asserts/images/menu.png"),
                              fit: BoxFit.fitWidth,
                            )),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
