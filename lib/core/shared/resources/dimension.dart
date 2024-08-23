import '../shared.dart';

class Dimension {
  static final size = _Size();
  static final radius = _Radius();
  static final padding = _Padding();
  static final divider = _Divider();
}

//! ################################################

//* ------------------- Radius -------------------
class _Radius {
  final double max = 100.0.r;
  final double thirtyTwo = 32.0.r;
  final double twentyFour = 24.0.r;
  final double tweenty = 20.0.r;
  final double sixteen = 16.0.r;
  final double twelve = 12.0.r;
  final double eight = 8.0.r;
  final double three = 3.0.r;
  final double one = 1.0.r;
} //? ------------------- Radius -------------------

//! ################################################

//* ------------------- Padding -------------------
class _Padding {
  final _HorizontalPadding horizontal = _HorizontalPadding();
  final _VerticalPadding vertical = _VerticalPadding();
}

class _HorizontalPadding {
  final double max = 16.0.w;
  final double large = 12.0.w;
  final double medium = 8.0.w;
  final double small = 4.0.w;
  final double verySmall = 2.0.w;
}

class _VerticalPadding {
  final double max = 16.0.h;
  final double large = 12.0.h;
  final double medium = 8.0.h;
  final double small = 4.0.h;
  final double verySmall = 2.0.h;
} //? ------------------- Padding -------------------

//! ################################################

//* ------------------- Size -------------------
class _Size {
  final _HorizontalSize horizontal = _HorizontalSize();
  final _VerticalSize vertical = _VerticalSize();
}

class _HorizontalSize {
  final double max = 1080.0.w;
  final double one = 1.0.w;
  final double four = 4.0.w;
  final double sixteen = 16.0.w;
  final double tweenty = 20.0.w;
  final double twentyFour = 24.0.w;
}

class _VerticalSize {
  final double max = 2400.0.h;
  final double sixteen = 16.0.h;
  final double tweenty = 20.0.h;
  final double twentyFour = 24.0.h;
  final double carousel = 104.0.h;
  final double min = 0.0.h;
} //? ------------------- Size -------------------

//! ################################################

//* ------------------- Divider -------------------
class _Divider {
  final double normal = 0.25.h;
  final double large = 0.5.h;
  final double veryLarge = 1.0.h;
  final double max = 4.0.h;
} //? ------------------- Divider -------------------
