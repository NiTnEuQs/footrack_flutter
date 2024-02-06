import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/screens/players_list/components/players_list_fab.dart';
import 'package:footrack_front/screens/players_list/components/players_list_app_bar.dart';
import 'package:footrack_front/screens/players_list/components/players_list_body.dart';
import 'package:footrack_front/screens/players_list/players_list_view_model.dart';
import 'package:footrack_front/shared/view_model_consumer_state.dart';

class PlayersListPage extends ConsumerStatefulWidget {
  const PlayersListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayersListPageState();
}

class _PlayersListPageState extends ViewModelConsumerState<PlayersListPage, PlayersListViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlayersListAppBar(),
      body: PlayersListBody(
        onPlayerLongPress: viewModel.editPlayer,
      ),
      floatingActionButton: PlayersListFab(
        onPress: viewModel.addPlayer,
      ),
    );
  }
}
