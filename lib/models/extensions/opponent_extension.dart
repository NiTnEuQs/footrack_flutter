import "package:footrack_front/models/opponent.dart";

extension OpponentExtension on Opponent? {
  // Getters

  String getName({String defaultValue = ""}) => this?.name ?? defaultValue;
}
