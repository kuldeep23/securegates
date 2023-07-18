import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static MediaQueryData _mediaQueryData(context) => MediaQuery.of(context);
  static double screenWidth(context) => _mediaQueryData(context).size.width;
  static double screenHeight(context) => _mediaQueryData(context).size.height;
  static Orientation orientation(context) =>
      _mediaQueryData(context).orientation;

  static double getProportionateScreenHeight(
      {required double inputHeight, required BuildContext context}) {
    double localScreenHeight = screenHeight(context);
    return (inputHeight / 812.0) * localScreenHeight;
  }

  static double getProportionateScreenWidth(
      {required double inputWidth, required BuildContext context}) {
    double localScreenWidth = screenWidth(context);
    return (inputWidth / 375.0) * localScreenWidth;
  }

  static final window = WidgetsBinding.instance.platformDispatcher.views.first;
  static Size size = window.physicalSize / window.devicePixelRatio;

  static double getHorizontalSize(double px) => px * (size.width / 375);

  static double getVerticalSize(double px) {
    num statusBar = MediaQueryData.fromView(window).viewPadding.top;
    num screenHeight = size.height - statusBar;
    return px * (screenHeight / 812);
  }

  static double getSize(double px) {
    final height = getVerticalSize(px);
    final width = getHorizontalSize(px);

    if (height < width) {
      return height.toInt().toDouble();
    } else {
      return width.toInt().toDouble();
    }
  }

  static double getFontSize(double px) => getSize(px);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
