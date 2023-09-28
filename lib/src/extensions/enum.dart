part of '../../fluiver.dart';

///
/// ```dart
/// enum Enums with ComparableEnum {
///   one,
///   two,
///   three;
/// }
/// ```
///
mixin EnumIndexComparable on Enum implements Comparable<Enum> {
  bool operator <(Enum other) => index < other.index;

  bool operator <=(Enum other) => index <= other.index;

  bool operator >(Enum other) => index > other.index;

  bool operator >=(Enum other) => index >= other.index;

  @override
  int compareTo(Enum other) => index - other.index;
}

extension IterableEnum<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String name) {
    for (final e in this) {
      if (e.name == name) {
        return e;
      }
    }
    return null;
  }

  T byNameOrElse(String name, {required T Function() orElse}) {
    for (final e in this) {
      if (e.name == name) {
        return e;
      }
    }
    return orElse();
  }

  List<String> names() => map<String>((e) => e.name).toList();
}
