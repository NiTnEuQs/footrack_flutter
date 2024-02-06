import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/screens/opponents_list/components/opponents_list_app_bar.dart';
import 'package:footrack_front/screens/opponents_list/components/opponents_list_body.dart';
import 'package:footrack_front/screens/opponents_list/components/opponents_list_fab.dart';
import 'package:footrack_front/screens/opponents_list/opponents_list_view_model.dart';
import 'package:footrack_front/shared/view_model_consumer_state.dart';

class OpponentsListPage extends ConsumerStatefulWidget {
  const OpponentsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpponentsListPageState();
}

class _OpponentsListPageState extends ViewModelConsumerState<OpponentsListPage, OpponentsListViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OpponentsListAppBar(),
      body: OpponentsListBody(
        onOpponentLongPress: viewModel.editOpponent,
      ),
      floatingActionButton: OpponentsListFab(
        onPress: viewModel.addOpponent,
      ),
    );
  }
}
