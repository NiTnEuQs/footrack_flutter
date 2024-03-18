import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_app_bar.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body.dart';
import 'package:footrack_front/screens/season_dashboard/season_dashboard_view_model.dart';
import 'package:footrack_front/shared/view_model_consumer_state.dart';

class SeasonDashboardScreen extends ConsumerStatefulWidget {
  const SeasonDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonDashboardScreenState();
}

class _SeasonDashboardScreenState extends ViewModelConsumerState<SeasonDashboardScreen, SeasonDashboardViewModel> {
  @override
  Widget build(BuildContext context) {
    var season = ref.watch(selectedSeasonProvider);

    return Scaffold(
      appBar: SeasonDashboardAppBar(
        season: season,
      ),
      body: SeasonDashboardBody(
        season: season,
        onNextMatchClick: viewModel.openNextMatch,
        onHealthClick: viewModel.openMatchsListPage,
        onSituationClick: viewModel.openMatchsListPage,
      ),
    );
  }
}
