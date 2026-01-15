import "package:footrack_front/models/club.dart";

class DummyClub {
  static final item = Club()
    ..teamName = "Dummy club name";

  static final list = List.filled(5, item);
}

