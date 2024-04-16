import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/models/season.dart";

class DummySeason {
  static final item = Season()
    ..name = "Dummy season name"
    ..from = DateTime.now().toTimestamp()
    ..to = DateTime.now().toTimestamp();

  static final list = List.filled(5, item);
}
