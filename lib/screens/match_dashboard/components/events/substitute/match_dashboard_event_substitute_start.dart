import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/substitute.dart';

class MatchDashboardEventSubstituteStart extends ConsumerWidget {
  const MatchDashboardEventSubstituteStart({
    Key? key,
    required this.substitute,
  }) : super(key: key);

  final Substitute substitute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var time = substitute.getTime()?.let((it) => "$it'") ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.compare_arrows,
          color: Colors.blue,
        ),
        if (substitute.getTime() != null)
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          )
      ],
    );
  }
}
