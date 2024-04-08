import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator.horizontal({
    super.key,
    this.padding,
    this.color,
    this.width,
    this.height = 1,
  });

  const Separator.vertical({
    super.key,
    this.padding,
    this.color,
    this.width = 1,
    this.height,
  });

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
