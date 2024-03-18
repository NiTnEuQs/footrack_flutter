import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/screens/opponents_list/components/opponents_list_body_empty.dart';
import 'package:footrack_front/screens/opponents_list/components/opponents_list_body_filled.dart';

class OpponentsListBody extends ConsumerWidget {
  const OpponentsListBody({
    super.key,
    this.onOpponentLongPress,
  });

  final Function(Opponent)? onOpponentLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var season = ref.watch(selectedSeasonProvider);
    var opponents = ref.watch(season.opponentsProvider);

    return opponents.isEmpty
        ? const OpponentsListBodyEmpty()
        : OpponentsListBodyFilled(
            opponents: opponents,
            onOpponentLongPress: onOpponentLongPress,
          );
  }
}
