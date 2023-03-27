extension ObjectExtension<T> on T {
  R let<R>(R Function(T it) op) => op(this);
}

extension ObjectFormatting on Comparable? {
  int compare(Comparable? o, {bool nullIsFirst = false}) {
    if (this == null) {
      return o == null ? 0 : (nullIsFirst ? -1 : 1);
    } else {
      return o == null ? (nullIsFirst ? 1 : -1) : this!.compareTo(o);
    }
  }
}
