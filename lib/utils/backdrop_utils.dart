import 'package:flutter/material.dart';
import 'package:obk/utils/global_value.dart';

class BackdropUtils {
  static Future<void> select() async {
    int i = await showDialog<int>(
        context: Global.appContext,
        builder: (BuildContext context) {
          return MonthSelector(insetPadding: const EdgeInsets.all(0.0));
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }
}

class MonthSelector extends Dialog {
  const MonthSelector({
    Key key,
    backgroundColor,
    elevation,
    insetAnimationDuration = const Duration(milliseconds: 100),
    insetAnimationCurve = Curves.decelerate,
    insetPadding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    clipBehavior = Clip.none,
    shape,
    child,
  })  : assert(clipBehavior != null),
        super(
            key: key,
            backgroundColor: backgroundColor,
            elevation: elevation,
            insetAnimationDuration: insetAnimationDuration,
            insetAnimationCurve: insetAnimationCurve,
            insetPadding: insetPadding,
            clipBehavior: clipBehavior,
            shape: shape,
            child: child);

  static const RoundedRectangleBorder _dialogShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)));
  static const double _elevation = 24.0;

  @override
  Widget build(BuildContext context) {
    var alertHeight = Global.screenHeight * 0.3268;
    var listHeight = Global.screenHeight * 0.28;

    final DialogTheme dialogTheme = DialogTheme.of(context);
    final EdgeInsets effectivePadding = MediaQuery.of(context).viewInsets + (insetPadding ?? const EdgeInsets.all(0.0));
    return AnimatedPadding(
      padding: effectivePadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 280.0, maxHeight: alertHeight),
            child: Material(
              color: backgroundColor ?? dialogTheme.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
              elevation: elevation ?? dialogTheme.elevation ?? _elevation,
              shape: shape ?? dialogTheme.shape ?? _dialogShape,
              type: MaterialType.card,
              clipBehavior: clipBehavior,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Global.screenHeight * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: FlatButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Text(
                                  "取消",
                                  style: TextStyle(fontSize: 30, color: const Color.fromRGBO(170, 170, 170, 1)),
                                ),
                                onPressed: () {})),
                        Expanded(
                            child: Text("选择日期",
                                textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: const Color.fromRGBO(51, 51, 51, 1)))),
                        Expanded(
                            child: FlatButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Text("确定", style: TextStyle(fontSize: 30, color: const Color.fromRGBO(43, 146, 255, 1))),
                                onPressed: () {})),
                      ],
                    ),
                  ),
                  Container(
                    height: listHeight,
                    padding: EdgeInsets.only(top: Global.screenHeight * 0.03),
                    child: Row(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: 100,
                                itemExtent: 20.0, //强制高度为50.0
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(title: Text("$index"));
                                })),
                        Expanded(
                            child: ListView.builder(
                                itemCount: 100,
                                itemExtent: 20.0, //强制高度为50.0
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(title: Text("$index"));
                                })),
                        Expanded(
                            child: ListView.builder(
                                itemCount: 100,
                                itemExtent: 20.0, //强制高度为50.0
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(title: Text("$index"));
                                }))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
