import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/screens/seasons_list/components/seasons_list_app_bar.dart';
import 'package:footrack_front/screens/seasons_list/components/seasons_list_body.dart';
import 'package:footrack_front/screens/seasons_list/components/seasons_list_fab.dart';
import 'package:footrack_front/screens/seasons_list/seasons_list_view_model.dart';
import 'package:footrack_front/shared/view_model_consumer_state.dart';

class SeasonsListScreen extends ConsumerStatefulWidget {
  const SeasonsListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonsListScreenState();
}

class _SeasonsListScreenState extends ViewModelConsumerState<SeasonsListScreen, SeasonsListViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SeasonsListAppBar(),
      body: SeasonsListBody(
        onSeasonPress: viewModel.openSeason,
        onSeasonLongPress: viewModel.editSeason,
      ),
      floatingActionButton: SeasonsListFab(
        onPress: viewModel.addSeason,
      ),
    );
  }
}
