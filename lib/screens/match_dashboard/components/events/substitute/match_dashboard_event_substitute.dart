import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/match_dashboard_event.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/substitute/match_dashboard_event_substitute_content.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/substitute/match_dashboard_event_substitute_start.dart';

class MatchDashboardEventSubstitute extends ConsumerWidget {
  const MatchDashboardEventSubstitute({
    Key? key,
    required this.substitute,
    this.onSubstitutePress,
    this.onSubstituteLongPress,
  }) : super(key: key);

  final Substitute substitute;
  final Function(Substitute substitute)? onSubstitutePress;
  final Function(Substitute substitute)? onSubstituteLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MatchDashboardEvent(
      event: substitute,
      startContent: MatchDashboardEventSubstituteStart(substitute: substitute),
      content: MatchDashboardEventSubstituteContent(substitute: substitute),
      onEventPress: () {
        onSubstitutePress?.call(substitute);
      },
      onEventLongPress: () {
        onSubstituteLongPress?.call(substitute);
      },
    );
  }
}
