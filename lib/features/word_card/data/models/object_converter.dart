class ObjectConverter {
  static List<T> _toList<T>(data, converter) => List.from(data.map(converter));

  static List<String> toStringList(data) {
    return data != null ? List<String>.from(data) : [];
  }
}
