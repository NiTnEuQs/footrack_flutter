import "package:flutter/material.dart";

extension WidgetExtension on Widget {
  Widget showIf(bool condition) => (condition ? this : Container());
}
