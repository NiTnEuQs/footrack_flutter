import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ViewModel {
  late BuildContext context;
  late WidgetRef ref;

  void init(BuildContext context, WidgetRef ref) {
    this.context = context;
    this.ref = ref;
  }

  void deactivate() {
    // Do nothing
  }

  void dispose() {
    // Do nothing
  }

  void update() {
    // Do nothing
  }
}
