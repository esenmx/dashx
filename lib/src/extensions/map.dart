part of fluiver;

typedef MapFilterPredicate<K, V> = bool Function(K key, V value);

extension MapX<K, V> on Map<K, V> {
  bool any(bool Function(K key, V value) test) {
    return entries.any((entry) {
      return test(entry.key, entry.value);
    });
  }

  MapEntry<K, V>? entry(K k) {
    if (containsKey(k)) {
      return MapEntry<K, V>(k, this[k] as V);
    }
    return null;
  }
}
