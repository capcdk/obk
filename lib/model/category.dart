class Category {
  final String name;
  bool picked;
  double padding = unselectedPadding;
  double fontSize = unselectedFontSize;

  static const double selectFontSize = 40.0;
  static const double selectPadding = 0.0;

  static const double unselectedFontSize = 25.0;
  static const double unselectedPadding = 15.0;

  static const scaleFontSize = selectFontSize - unselectedFontSize;
  static const scalePadding = unselectedPadding - selectPadding;

  Category({this.name = "", this.picked = false});

  void setPickStatus(bool picked) {
    this.picked = picked;
    if (picked) {
      this.padding = selectPadding;
      this.fontSize = selectFontSize;
    } else {
      this.padding = unselectedPadding;
      this.fontSize = unselectedFontSize;
    }
  }

  void scale(double scale) {
    double newFontSize = unselectedFontSize + (scale * scaleFontSize);
    double newPadding = unselectedPadding - (scale * scalePadding);

    if (newFontSize >= unselectedFontSize && newFontSize <= selectFontSize) {
      this.fontSize = newFontSize;
    }
    if (newPadding >= selectPadding && newPadding <= unselectedPadding) {
      this.padding = newPadding;
    }
  }
}