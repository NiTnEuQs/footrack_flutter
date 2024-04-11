import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/converters/match_type_converter.dart";
import "package:footrack_front/enums/match_type_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/goal.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/models/opponent.dart";
import "package:footrack_front/models/squad_player.dart";
import "package:footrack_front/models/substitute.dart";

extension MatchExtension on Match? {
  // Getters

  MatchTypeEnum getType({MatchTypeEnum defaultValue = MatchTypeEnum.championship}) =>
      this?.type?.let((it) => const MatchTypeConverter().fromJson(it)) ?? defaultValue;

  DateTime? getDate({DateTime? defaultValue}) => this?.date.toDateTime() ?? defaultValue;

  int? getTime({int? defaultValue}) => this?.time ?? defaultValue;

  int getScoreOpponent({int defaultValue = 0}) => this?.scoreOpponent ?? defaultValue;

  Opponent? getOpponent(WidgetRef ref) => this?.opponentProvider.let((it) => ref.watch(it));

  List<Goal> getGoals(WidgetRef ref) => this?.goalsProvider.let((it) => ref.watch(it)) ?? [];

  List<Substitute> getSubstitutes(WidgetRef ref) => this?.substitutesProvider.let((it) => ref.watch(it)) ?? [];

  List<SquadPlayer> getSquad(WidgetRef ref) => this?.squadProvider.let((it) => ref.watch(it)) ?? [];

  // Others

  int getTotalScoreTeam(WidgetRef ref) => getGoals(ref).length;

  bool isWon(WidgetRef ref) => getTotalScoreTeam(ref) > getScoreOpponent();

  bool isLoss(WidgetRef ref) => getTotalScoreTeam(ref) < getScoreOpponent();

  bool isEven(WidgetRef ref) => getTotalScoreTeam(ref) == getScoreOpponent();

  String resultString(WidgetRef ref) {
    if (this?.scoreOpponent == null) {
      return "Erreur";
    } else if (isEven(ref)) {
      return "Egalité";
    } else if (isLoss(ref)) {
      return "Défaite";
    } else {
      return "Victoire";
    }
  }

  Color resultColor(WidgetRef ref) {
    if (this?.scoreOpponent == null) {
      return Colors.black;
    } else if (isEven(ref)) {
      return Colors.black.withAlpha(150);
    } else if (isLoss(ref)) {
      return Colors.red.withAlpha(200);
    } else {
      return Colors.lightGreen;
    }
  }

  FontWeight teamFontWeight(WidgetRef ref) {
    if (this?.scoreOpponent == null) {
      return FontWeight.normal;
    } else if (isWon(ref)) {
      return FontWeight.bold;
    }

    return FontWeight.normal;
  }

  FontWeight opponentFontWeight(WidgetRef ref) {
    if (this?.scoreOpponent == null) {
      return FontWeight.normal;
    } else if (isLoss(ref)) {
      return FontWeight.bold;
    }

    return FontWeight.normal;
  }
}
