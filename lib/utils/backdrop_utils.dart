import 'package:flutter/material.dart';
import 'package:obk/utils/global_value.dart';

class BackdropUtils {
  static Future<void> select() async {
    int i = await showAnimationDialog<int>(
        context: Global.appContext,
        builder: (BuildContext context) {
          return const MonthSelector(insetPadding: const EdgeInsets.all(0.0));
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }

  static Future<T> showAnimationDialog<T>(
      {@required BuildContext context,
      bool barrierDismissible = true,
      @Deprecated('') Widget child,
      WidgetBuilder builder,
      bool useRootNavigator = true,
      RouteSettings routeSettings}) {
    assert(child == null || builder == null);
    assert(useRootNavigator != null);
    assert(debugCheckHasMaterialLocalizations(context));

    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        final Widget pageChild = child ?? Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset(0.0, 0.0))
              .animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
          child: child,
        );
      },
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
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
    var alertHeight = Global.screenHeight * 0.31;
    var listHeight = Global.screenHeight * 0.24;

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
                    padding: EdgeInsets.only(
                        top: Global.screenHeight * 0.025, left: Global.screenWidth * 0.05, right: Global.screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: FlatButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Text(
                                      "取消",
                                      style: TextStyle(fontSize: 36, color: const Color.fromRGBO(170, 170, 170, 1)),
                                    ),
                                    onPressed: () {}))),
                        Expanded(
                            child: Text("选择日期",
                                textAlign: TextAlign.center, style: TextStyle(fontSize: 36, color: const Color.fromRGBO(51, 51, 51, 1)))),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Text("确定", style: TextStyle(fontSize: 36, color: const Color.fromRGBO(43, 146, 255, 1))),
                                    onPressed: () {}))),
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
