import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/player_event.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/match_dashboard_events_list_empty.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/match_dashboard_events_list_filled.dart';

class MatchDashboardEventsList extends ConsumerWidget {
  const MatchDashboardEventsList({
    Key? key,
    required this.events,
    this.onEventPress,
    this.onEventLongPress,
  }) : super(key: key);

  final List<PlayerEvent> events;
  final Function(PlayerEvent event)? onEventPress;
  final Function(PlayerEvent event)? onEventLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return events.isEmpty
        ? const MatchDashboardEventsListEmpty()
        : MatchDashboardEventsListFilled(
            events: events,
            onEventPress: onEventPress,
            onEventLongPress: onEventLongPress,
          );
  }
}
