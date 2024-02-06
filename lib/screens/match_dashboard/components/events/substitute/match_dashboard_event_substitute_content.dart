import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/text_icon.dart';
import 'package:footrack_front/models/substitute.dart';

class MatchDashboardEventSubstituteContent extends ConsumerWidget {
  const MatchDashboardEventSubstituteContent({
    Key? key,
    required this.substitute,
    this.onSubstitutePress,
    this.onSubstituteLongPress,
  }) : super(key: key);

  final Substitute substitute;
  final Function(Substitute? substitute)? onSubstitutePress;
  final Function(Substitute? substitute)? onSubstituteLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var playerIn = ref.watch(substitute.playerInProvider)?.getName() ?? "";
    var playerOut = ref.watch(substitute.playerOutProvider)?.getName() ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextIcon(
          text: playerIn,
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.green,
              ),
        ),
        TextIcon(
          text: playerOut,
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
              ),
        ),
      ],
    );
  }
}
