import "package:flutter/material.dart";

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);

  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  EdgeInsets get viewPadding => const EdgeInsets.symmetric(vertical: 15, horizontal: 10);

  double pHeight(double value) => mediaQuery.size.height * value;
  double pWidth(double value) => mediaQuery.size.width * value;
}
