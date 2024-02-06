import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/generics/generic_loading.dart';
import 'package:footrack_front/database/global_providers.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_app_bar.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body.dart';
import 'package:footrack_front/screens/season_dashboard/season_dashboard_view_model.dart';
import 'package:footrack_front/components/generics/generic_error.dart';
import 'package:footrack_front/shared/view_model_consumer_state.dart';

class SeasonDashboardPage extends ConsumerStatefulWidget {
  const SeasonDashboardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonDashboardPageState();
}

class _SeasonDashboardPageState extends ViewModelConsumerState<SeasonDashboardPage, SeasonDashboardViewModel> {
  @override
  Widget build(BuildContext context) {
    var seasonStream = ref.watch(seasonStreamProvider);

    return seasonStream.when(
      data: (season) {
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
      },
      error: (error, stacktrace) => GenericError(error: error),
      loading: () => const GenericLoading(),
    );
  }
}
