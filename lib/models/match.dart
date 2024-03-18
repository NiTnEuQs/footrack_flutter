import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/converters/match_type_converter.dart';
import 'package:footrack_front/enums/match_type_enum.dart';
import 'package:footrack_front/extensions/snapshot_extensions.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/models/substitute.dart';

part 'match.flamingo.dart';

class Match extends Document<Match> {
  Match({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
    WidgetRef? ref,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef) {
    goals = Collection(this, MatchKey.goals.value);
    substitutes = Collection(this, MatchKey.substitutes.value);

    init(ref);
  }

  void init(WidgetRef? ref) {
    firestoreInstance.collection(goals.ref.path).snapshots().listen((snap) {
      ref?.read(goalsProvider.notifier).state = snap.map((e) => Goal(snapshot: e, ref: ref));
    });

    firestoreInstance.collection(substitutes.ref.path).snapshots().listen((snap) {
      ref?.read(substitutesProvider.notifier).state = snap.map((e) => Substitute(snapshot: e, ref: ref));
    });

    if (opponent != null) {
      firestoreInstance.doc(opponent!.path).snapshots().listen((snap) {
        ref?.read(opponentProvider.notifier).state = Opponent(snapshot: snap);
      });
    }
  }

  @Field()
  String? type;

  MatchTypeEnum getType() => const MatchTypeConverter().fromJson(type);

  @Field()
  DocumentReference? opponent;
  final opponentProvider = StateProvider<Opponent?>((_) => null);

  @Field()
  Timestamp? date;

  @Field()
  String? status;

  @Field()
  int? halfTime;

  int getHalfTime({int defaultValue = 0}) => halfTime ?? defaultValue;

  @Field()
  int? time;

  @Field()
  int? scoreOpponent;

  int getScoreOpponent({int defaultValue = 0}) => scoreOpponent ?? defaultValue;

  @SubCollection()
  late Collection<Goal> goals;
  final goalsProvider = StateProvider<List<Goal>>((_) => []);

  @SubCollection()
  late Collection<Substitute> substitutes;
  final substitutesProvider = StateProvider<List<Substitute>>((_) => []);

  int getTotalScoreTeam(WidgetRef ref) {
    return ref.watch(goalsProvider).length;
  }

  bool isWon(WidgetRef ref) {
    return getTotalScoreTeam(ref) > getScoreOpponent();
  }

  bool isLoss(WidgetRef ref) {
    return getTotalScoreTeam(ref) < getScoreOpponent();
  }

  bool isEven(WidgetRef ref) {
    return getTotalScoreTeam(ref) == getScoreOpponent();
  }

  String resultString(WidgetRef ref) {
    if (scoreOpponent == null) {
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
    if (scoreOpponent == null) {
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
    if (scoreOpponent == null) {
      return FontWeight.normal;
    } else if (isWon(ref)) {
      return FontWeight.bold;
    }

    return FontWeight.normal;
  }

  FontWeight opponentFontWeight(WidgetRef ref) {
    if (scoreOpponent == null) {
      return FontWeight.normal;
    } else if (isLoss(ref)) {
      return FontWeight.bold;
    }

    return FontWeight.normal;
  }

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);

  bool hasBegun() => (time ?? -1) >= 0;
}
