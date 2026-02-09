import "package:flutter/material.dart";

extension ComposeModifiersOnFlutterWidgets on Widget {
  Widget centered() => Center(child: this);

  Widget expanded() => Expanded(child: this);

  Widget fillMaxWidth({double? width = double.infinity, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  Widget fillMaxHeight({double? width, double? height = double.infinity}) =>
      SizedBox(width: width, height: height, child: this);

  Widget size({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  Widget flex({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget aspectRatio(double ratio) =>
      AspectRatio(aspectRatio: ratio, child: this);

  Widget padding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);

  Widget decoration(BoxDecoration decoration) =>
      DecoratedBox(decoration: decoration, child: this);

  Widget clipRRect(BorderRadiusGeometry borderRadius) =>
      ClipRRect(borderRadius: borderRadius, child: this);

  Widget transform(Matrix4 transform) =>
      Transform(transform: transform, child: this);

  Widget scrollable() => SingleChildScrollView(child: this);

  Widget scrollableVertical() =>
      SingleChildScrollView(scrollDirection: Axis.vertical, child: this);

  Widget scrollableHorizontal() =>
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: this);

  Widget backgroundColor(Color color) =>
      DecoratedBox(decoration: BoxDecoration(color: color), child: this);
}
