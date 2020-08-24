import 'package:flutter/material.dart';
import 'package:obk/model/category.dart';

class CategorySlidePicker extends StatefulWidget {
  final int defaultCategorySelectIndex;

  CategorySlidePicker({Key key, this.defaultCategorySelectIndex = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryState();
}

class _CategoryState extends State<CategorySlidePicker> {
  List<Category> _categoryList = [
    Category(),
    Category(),
    Category(),
    Category(name: "其他"),
    Category(name: "日用"),
    Category(name: "餐饮"),
    Category(name: "贷款"),
    Category(name: "交通"),
    Category(name: "娱乐"),
    Category(name: "家用"),
    Category(name: "消费"),
    Category(),
    Category(),
    Category()
  ];
  int _categoryCnt = 8;
  final emptyCategoryPadding = 3;
  ScrollController _controller;
  bool isScrollEndNotification = false;
  double _startLocation = 0;
  double _lastUpdateLocation = 0;
  double _endLocation = 0;
  int _currentSelectCategoryIndex = 0;

  double _calItemWidth({screenWidth}) => (screenWidth ?? MediaQuery.of(context).size.width) / 6;

  double _calStandCategoryOffset(int categoryIndex, double itemWidth) => (categoryIndex * itemWidth) + (itemWidth / 2);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var itemWidth = _calItemWidth();
    int categorySelectIndex = widget.defaultCategorySelectIndex > 0 ? widget.defaultCategorySelectIndex : 0;
    var selectCategory = _categoryList[categorySelectIndex + emptyCategoryPadding];
    selectCategory.setPickStatus(true);
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

    return Container(
        width: screenWidth,
        child: NotificationListener<ScrollNotification>(
            child: ListView.builder(
                itemCount: _categoryList.length,
                itemExtent: singleItemWidth,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                controller: _controller,
                itemBuilder: (BuildContext context, int index) => _categoryItem(index, singleItemWidth)),
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollStartNotification) {
                isScrollEndNotification = false;
                _startLocation = notification.metrics.pixels;
                _lastUpdateLocation = _startLocation;
              }
              if (notification is ScrollUpdateNotification) {
                var currentLocation = notification.metrics.pixels;
                if (currentLocation != _lastUpdateLocation) {
                  print("update=$currentLocation, start=$_startLocation");

                  // 计算新分类的下标
                  int newCurrentCategoryIndex = currentLocation ~/ singleItemWidth;
                  if (newCurrentCategoryIndex >= 0 && newCurrentCategoryIndex <= _categoryCnt - 1) {
                    var newCurrentStandardOffset = _calStandCategoryOffset(newCurrentCategoryIndex, singleItemWidth);
                    var newCurrentCategory = _categoryList[newCurrentCategoryIndex + emptyCategoryPadding];
                    bool isLeftSide = currentLocation < newCurrentStandardOffset;

                    var asideCategoryIndex = newCurrentCategoryIndex + (isLeftSide ? -1 : 1);
                    var asideCategory = _categoryList[asideCategoryIndex + emptyCategoryPadding];

                    // 计算控件大小偏移
                    var offsetScale = (currentLocation - newCurrentStandardOffset).abs() / singleItemWidth;
                    print(
                        "scale: offsetScale=$offsetScale, current=$_currentSelectCategoryIndex, newCurrent=$newCurrentCategoryIndex, aside=$asideCategoryIndex, ");
                    setState(() {
                      // 当前控件缩小
                      newCurrentCategory.scale(1 - offsetScale);
                      // 趋向的控件放大
                      asideCategory.scale(offsetScale);

                      if (newCurrentCategoryIndex != _currentSelectCategoryIndex) {
                        var oldCurrentCategory = _categoryList[_currentSelectCategoryIndex + emptyCategoryPadding];
                        oldCurrentCategory.picked = false;
                        oldCurrentCategory.scale(0);
                        _categoryList[newCurrentCategoryIndex + emptyCategoryPadding].picked = true;
                        _currentSelectCategoryIndex = newCurrentCategoryIndex;
                      }
                    });
                  }
                }
                _lastUpdateLocation = currentLocation;
              }
              if (notification is ScrollEndNotification && !isScrollEndNotification) {
                _endLocation = notification.metrics.pixels;
                print("start=$_startLocation, end=$_endLocation");
                isScrollEndNotification = true;
                if (_endLocation == _startLocation) {
                  return true;
                }
                var jumpOffset = _calStandCategoryOffset(_currentSelectCategoryIndex, singleItemWidth);
                _controller.animateTo(jumpOffset, duration: const Duration(milliseconds: 100), curve: Curves.ease);
                setState(() {
                  _categoryList[_currentSelectCategoryIndex + emptyCategoryPadding].scale(1);
                });
                print("jumpToOffset=$jumpOffset");
              }
              return true;
            }));
  }

  // 创建分类项组件
  Widget _categoryItem(int itemIndex, double itemWidth) {
    Category category = _categoryList[itemIndex];
    if (category.name.isEmpty) {
      return SizedBox(width: itemWidth);
    }
    return Container(
      padding: EdgeInsets.all(category.padding),
      child: FlatButton(
        child: Text(category.name, style: TextStyle(fontSize: category.fontSize)),
        color: category.picked ? Colors.blue : Colors.white,
        textColor: category.picked ? Colors.white : Colors.blue,
        shape: CircleBorder(side: BorderSide(color: Colors.blue)),
        onPressed: () {
          // 滑动到中间位置
          var offset = ((itemIndex - emptyCategoryPadding) * itemWidth) + (itemWidth / 2);
          _controller.animateTo(offset, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
