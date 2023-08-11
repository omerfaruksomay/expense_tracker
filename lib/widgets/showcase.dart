import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowcaseWidget extends StatelessWidget {
  const ShowcaseWidget({
    super.key,
    required this.globalKey,
    required this.title,
    required this.desc,
    required this.child,
    required this.onClick,
    this.shapeBorder = const CircleBorder(),
  });
  final GlobalKey globalKey;
  final String title;
  final String desc;
  final Widget child;
  final ShapeBorder shapeBorder;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      description: desc,
      title: title,
      targetShapeBorder: shapeBorder,
      onBarrierClick: onClick,
      child: child,
    );
  }
}
