import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator.horizontal({
    Key? key,
    this.padding,
    this.color,
    this.width,
    this.height = 1,
  }) : super(key: key);

  const Separator.vertical({
    Key? key,
    this.padding,
    this.color,
    this.width = 1,
    this.height,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      color: color ?? Colors.black.withAlpha(20),
    );
  }
}
