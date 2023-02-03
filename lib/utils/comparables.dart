import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/utils/tuples.dart';

int compare(Comparable a, Comparable b) => a.compare(b);

int comparePairFirst(Pair<Comparable, Comparable> a, Pair<Comparable, Comparable> b) => a.first.compare(b.first);

int comparePairSecond(Pair<Comparable, Comparable> a, Pair<Comparable, Comparable> b) => a.second.compare(b.second);
