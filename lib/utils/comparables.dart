import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/utils/tuples.dart';

// Compare first

int comparePairFirst(Pair<Comparable?, Comparable?> a, Pair<Comparable?, Comparable?> b, {bool ascending = true}) {
  return ascending ? a.first.compare(b.first) : b.first.compare(a.first);
}

int comparePairFirstAsc(Pair<Comparable?, Comparable?> a, Pair<Comparable?, Comparable?> b) =>
    comparePairFirst(a, b, ascending: true);

int comparePairFirstDesc(Pair<Comparable?, Comparable?> a, Pair<Comparable?, Comparable?> b) =>
    comparePairFirst(a, b, ascending: false);

// Compare second

int comparePairSecond(Pair<Comparable?, Comparable?> a, Pair<Comparable?, Comparable?> b, {bool ascending = true}) {
  return ascending ? a.second.compare(b.second) : b.second.compare(a.second);
}

int comparePairSecondAsc(Pair<Comparable?, Comparable?> a, Pair<Comparable?, Comparable?> b) =>
    comparePairSecond(a, b, ascending: true);

int comparePairSecondDesc(Pair<Comparable?, Comparable?> a, Pair<Comparable?, Comparable?> b) =>
    comparePairSecond(a, b, ascending: false);
