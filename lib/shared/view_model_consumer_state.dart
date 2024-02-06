import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/di/dependency_injection.dart';
import 'package:footrack_front/shared/view_model.dart';

abstract class ViewModelConsumerState<T extends ConsumerStatefulWidget, U extends ViewModel> extends ConsumerState<T> {
  final viewModel = DependencyInjection.getIt.get<U>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context, ref);
    });
  }

  @override
  void dispose() {
    viewModel.dispose();

    super.dispose();
  }

  @override
  void deactivate() {
    viewModel.deactivate();

    super.deactivate();
  }
}
