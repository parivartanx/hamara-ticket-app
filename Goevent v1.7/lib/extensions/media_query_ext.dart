
import 'package:flutter/widgets.dart';

extension MediaQueryExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get width => screenSize.width;

  double get height => screenSize.height;

  double get screenAspectRatio => screenSize.aspectRatio;

  double get screenDensity => MediaQuery.of(this).devicePixelRatio;

  EdgeInsets get screenPadding => MediaQuery.of(this).padding;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => orientation == Orientation.landscape;
}