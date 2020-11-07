import 'package:flutter/material.dart';
import 'file:///D:/code/github/obk/lib/custom_widget/slide_picker_item.dart';

class SlidePicker extends StatefulWidget {
  int defaultSelectIndex;
  int emptyItemPadding;
  Color pickedColor;
  Color unpickedColor;
  List<SlidePickerItem> itemList;
  ShapeBorder shape;

  SlidePicker(
      {Key key, this.itemList, this.pickedColor, this.unpickedColor, this.emptyItemPadding = 0, this.defaultSelectIndex = 2, this.shape})
      : assert(itemList.isNotEmpty),
        assert(pickedColor != null),
        assert(unpickedColor != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SlidePickerState(itemList, emptyItemPadding, pickedColor, unpickedColor, shape);
}

class _SlidePickerState extends State<SlidePicker> {
  _SlidePickerState(this._itemList, this.emptyItemPadding, this.pickedColor, this.unpickedColor, this.shape) {
    this.actualItemCnt = _itemList.length;
    SlidePickerItem emptyItem = SlidePickerItem();
    for (int i = 0; i < emptyItemPadding; i++) {
      this._itemList.insert(0, emptyItem);
    }

    for (int i = 0; i < emptyItemPadding; i++) {
      this._itemList.add(emptyItem);
    }
  }

  Color pickedColor;
  Color unpickedColor;
  ShapeBorder shape;
  List<SlidePickerItem> _itemList = [];

  int actualItemCnt;
  int emptyItemPadding;
  ScrollController _controller;
  bool isScrollEndNotification = false;
  double _startLocation = 0;
  double _lastUpdateLocation = 0;
  double _endLocation = 0;
  int _currentSelectItemIndex = 0;

  double _calItemWidth({screenWidth}) => (screenWidth ?? MediaQuery.of(context).size.width) / 6;

  double _calStandItemOffset(int categoryIndex, double itemWidth) => (categoryIndex * itemWidth) + (itemWidth / 2);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var itemWidth = _calItemWidth();
    int categorySelectIndex = widget.defaultSelectIndex > 0 ? widget.defaultSelectIndex : 0;
    var selectCategory = _itemList[categorySelectIndex + emptyItemPadding];
    selectCategory.setPickStatus(true);
    var initialOffset = categorySelectIndex * itemWidth + (itemWidth / 2);
    _controller = ScrollController(initialScrollOffset: initialOffset);
    print("initialScrollOffset=$initialOffset");
    _currentSelectItemIndex = categorySelectIndex;
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
                itemCount: _itemList.length,
                itemExtent: singleItemWidth,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                controller: _controller,
                itemBuilder: (BuildContext context, int index) => _createItemWidget(index, singleItemWidth, shape)),
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollStartNotification) {
                isScrollEndNotification = false;
                _startLocation = notification.metrics.pixels;
                _lastUpdateLocation = _startLocation;
              }
              if (notification is ScrollUpdateNotification) {
                var currentLocation = notification.metrics.pixels;
                if (currentLocation != _lastUpdateLocation) {
                  // 计算新选中项的下标
                  int newCurrentItemIndex = currentLocation ~/ singleItemWidth;
                  if (newCurrentItemIndex >= 0 && newCurrentItemIndex <= actualItemCnt - 1) {
                    var newCurrentStandardOffset = _calStandItemOffset(newCurrentItemIndex, singleItemWidth);
                    var newCurrentItem = _itemList[newCurrentItemIndex + emptyItemPadding];
                    bool isLeftSide = currentLocation < newCurrentStandardOffset;

                    var asideItemIndex = newCurrentItemIndex + (isLeftSide ? -1 : 1);
                    var asideItem = _itemList[asideItemIndex + emptyItemPadding];

                    // 计算控件大小偏移
                    var offsetScale = (currentLocation - newCurrentStandardOffset).abs() / singleItemWidth;
                    setState(() {
                      // 当前控件缩小
                      newCurrentItem.scale(1 - offsetScale);
                      // 趋向的控件放大
                      asideItem.scale(offsetScale);

                      if (newCurrentItemIndex != _currentSelectItemIndex) {
                        var oldCurrentItem = _itemList[_currentSelectItemIndex + emptyItemPadding];
                        oldCurrentItem.picked = false;
                        oldCurrentItem.scale(0);
                        _itemList[newCurrentItemIndex + emptyItemPadding].picked = true;
                        _currentSelectItemIndex = newCurrentItemIndex;
                      }
                    });
                  }
                }
                _lastUpdateLocation = currentLocation;
              }
              if (notification is ScrollEndNotification && !isScrollEndNotification) {
                _endLocation = notification.metrics.pixels;
                isScrollEndNotification = true;
                if (_endLocation == _startLocation) {
                  return true;
                }
                var jumpOffset = _calStandItemOffset(_currentSelectItemIndex, singleItemWidth);
                _controller.animateTo(jumpOffset, duration: const Duration(milliseconds: 100), curve: Curves.ease);
                setState(() {
                  _itemList[_currentSelectItemIndex + emptyItemPadding].scale(1);
                });
              }
              return true;
            }));
  }

  // 创建列表项组件
  Widget _createItemWidget(int itemIndex, double itemWidth, ShapeBorder shape) {
    SlidePickerItem item = _itemList[itemIndex];
    if (item.name.isEmpty) {
      return SizedBox(width: itemWidth);
    }
    return Container(
      padding: EdgeInsets.all(item.padding),
      child: FlatButton(
        child: Text(item.name, style: TextStyle(fontSize: item.fontSize)),
        color: item.picked ? pickedColor : unpickedColor,
        textColor: item.picked ? unpickedColor : pickedColor,
        shape: shape,
        onPressed: () {
          // 滑动到中间位置
          var offset = ((itemIndex - emptyItemPadding) * itemWidth) + (itemWidth / 2);
          _controller.animateTo(offset, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
