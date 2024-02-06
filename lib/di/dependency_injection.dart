import 'package:footrack_front/screens/match_dashboard/match_dashboard_view_model.dart';
import 'package:footrack_front/screens/opponents_list/opponents_list_view_model.dart';
import 'package:footrack_front/screens/players_list/players_list_view_model.dart';
import 'package:footrack_front/screens/season_dashboard/season_dashboard_view_model.dart';
import 'package:footrack_front/screens/seasons_list/seasons_list_view_model.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<SeasonsListViewModel>(SeasonsListViewModel());
    getIt.registerSingleton<SeasonDashboardViewModel>(SeasonDashboardViewModel());
    getIt.registerSingleton<MatchDashboardViewModel>(MatchDashboardViewModel());
    getIt.registerSingleton<PlayersListViewModel>(PlayersListViewModel());
    getIt.registerSingleton<OpponentsListViewModel>(OpponentsListViewModel());
  }
}
