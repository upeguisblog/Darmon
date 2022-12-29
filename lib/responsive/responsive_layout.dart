import 'package:flutter/material.dart';
import 'package:app_3/responsive/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {Key? key, required this.mobileBody, required this.desktopApp})
      : super(key: key);

  final Widget mobileBody;
  final Widget desktopApp;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileWidth) {
        return mobileBody;
      } else {
        return desktopApp;
      }
    });
  }
}
