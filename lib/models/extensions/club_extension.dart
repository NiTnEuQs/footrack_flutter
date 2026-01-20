import "package:footrack_front/models/club.dart";

extension ClubExtension on Club? {
  // Getters

  String getTeamName({String defaultValue = ""}) =>
      this?.teamName ?? defaultValue;
}
