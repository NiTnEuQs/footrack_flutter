import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_firestore.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/season.dart';

final dbProvider = Provider((_) => DatabaseFirestore());
final languageCodeProvider = StateProvider<String>((_) => "fr");

final seasonsProvider = StateProvider<List<Season>>((_) => []);
final seasonChoseProvider = StateProvider<Season?>((_) => null);
final matchChoseProvider = StateProvider<Match?>((_) => null);
