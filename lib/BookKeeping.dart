import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookKeepingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = ScrollController();
    controller.addListener(() {
      print(controller.offset);
    });
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
            child: TextField(
              style: TextStyle(fontSize: 60),
              cursorWidth: 6,
              cursorColor: Colors.black,
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: " 请输入金额",
                  hintStyle: TextStyle(fontSize: 60, color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  prefixText: "￥",
                  prefixStyle: TextStyle(fontSize: 60, fontWeight: FontWeight.w600)),
            ),
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
          // 键盘
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}

class CategorySlidePicker extends StatefulWidget {
  final int defaultCategorySelectIndex;

  CategorySlidePicker({Key key, this.defaultCategorySelectIndex = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryState();
}

class _Category {
  final String name;
  bool picked;

  _Category({this.name = "", this.picked = false});
}

class _CategoryState extends State<CategorySlidePicker> {
  List<_Category> _categoryList = [
    _Category(),
    _Category(),
    _Category(),
    _Category(name: "其他"),
    _Category(name: "日用"),
    _Category(name: "餐饮"),
    _Category(name: "贷款"),
    _Category(name: "交通"),
    _Category(name: "娱乐"),
    _Category(name: "家用"),
    _Category(name: "消费"),
    _Category(),
    _Category(),
    _Category()
  ];
  final emptyCategoryPadding = 3;
  ScrollController _controller;
  bool isScrollEndNotification = false;
  double _startLocation = 0;
  double _endLocation = 0;
  int _currentSelectCategoryIndex = 0;

  double _calItemWidth({screenWidth}) => (screenWidth ?? MediaQuery.of(context).size.width) / 6;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var itemWidth = _calItemWidth();
    int categorySelectIndex = widget.defaultCategorySelectIndex > 0 ? widget.defaultCategorySelectIndex : 0;
    _categoryList[categorySelectIndex + emptyCategoryPadding].picked = true;
    var initialOffset = categorySelectIndex * itemWidth + (itemWidth / 2);
    _controller = ScrollController(initialScrollOffset: initialOffset);
    print("initialScrollOffset=$initialOffset");
    _currentSelectCategoryIndex = categorySelectIndex;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double singleItemWidth = _calItemWidth(screenWidth: screenWidth);
    var lent = _categoryList.length;

    return Container(
        width: screenWidth,
        child: NotificationListener<ScrollNotification>(
            child: ListView.builder(
                itemCount: lent,
                itemExtent: singleItemWidth,
                scrollDirection: Axis.horizontal,
                controller: _controller,
                itemBuilder: (BuildContext context, int index) => _categoryItem(index, singleItemWidth)),
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollStartNotification) {
                isScrollEndNotification = false;
                _startLocation = notification.metrics.pixels;
              }
              if (notification is ScrollEndNotification && !isScrollEndNotification) {
                _endLocation = notification.metrics.pixels;
                print("start=$_startLocation, end=$_endLocation");
                isScrollEndNotification = true;
                if (_endLocation == _startLocation) {
                  return true;
                }
                int newCategoryIndex = _endLocation ~/ singleItemWidth;
                if (_endLocation % singleItemWidth > singleItemWidth / 2) {
                  newCategoryIndex += 1;
                }
                var jumpOffset = (newCategoryIndex * singleItemWidth) + (singleItemWidth / 2);
//                _controller.animateTo(jumpOffset, duration: Duration(milliseconds: 400), curve: Curves.ease);
                _controller.jumpTo(jumpOffset);
                print("jumpToOffset=$jumpOffset");
                setState(() {
                  _categoryList[_currentSelectCategoryIndex + emptyCategoryPadding].picked = false;
                  _categoryList[newCategoryIndex + emptyCategoryPadding].picked = true;
                  _currentSelectCategoryIndex = newCategoryIndex;
                });
              }
              return true;
            }));
  }

  Widget _categoryItem(int itemIndex, double itemWidth) {
    _Category category = _categoryList[itemIndex];
    if (category.name.isEmpty) {
      return SizedBox(width: itemWidth);
    }
    return Container(
//      padding: EdgeInsets.only(
//          left: (category.picked ? 0 : 10), right: (category.picked ? 0 : 10)),
      padding: EdgeInsets.all(category.picked ? 0 : 15),
      child: FlatButton(
        child: Text(category.name, style: TextStyle(fontSize: category.picked ? 40 : 25)),
        color: category.picked ? Colors.blue : Colors.white,
        textColor: category.picked ? Colors.white : Colors.blue,
        shape: CircleBorder(side: BorderSide(color: Colors.blue)),
        onPressed: () {
          // 滑动到中间位置
          var offset = ((itemIndex - emptyCategoryPadding) * itemWidth) + (itemWidth / 2);
          _controller.animateTo(offset, duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
