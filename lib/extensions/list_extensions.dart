extension ListExtension<T> on Iterable<List<T>> {
  List<T> reduceMerge() => reduce(merge);

  List<T> merge(List<T> a, List<T> b) => [...a, ...b];
}

extension IterableExtension on Iterable<int> {
  int reduceAdd() => reduce(add);

  int add(int a, int b) => a + b;
}
