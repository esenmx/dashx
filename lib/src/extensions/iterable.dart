part of fluiver;

extension IterableX<E> on Iterable<E> {
  /// ```dart
  /// [1].convertTo2D(2) // [[1]]
  /// [1, 2, 3, 4].convertTo2D(2) // [[1, 2], [3, 4]]
  /// [1, 2, 3, 4].convertTo2D(3) // [[1, 2, 3], [4]]
  /// ```
  Iterable<List<E>> to2D(int div) sync* {
    RangeError.checkValueInInterval(div, 1, 1 << 31);
    final iterator = this.iterator;
    while (iterator.moveNext()) {
      final subArray = <E>[iterator.current];
      for (int i = 0; i < div - 1; i++) {
        if (iterator.moveNext()) {
          subArray.add(iterator.current);
        } else {
          break;
        }
      }
      yield subArray;
    }
  }

  /// Creates a [Map] that has groupped [Iterable] elements as [List] with
  /// specified [groupper] parameter.
  /// Useful for categorizing/groupping [Widget]s when data comes as flat [List]
  Map<G, List<E>> groupAsMap<G>(G Function(E element) groupper) {
    final map = <G, List<E>>{};
    for (var e in this) {
      final key = groupper(e);
      map[key] ??= <E>[];
      map[key]!.add(e);
    }
    return map;
  }

  /// Useful for widgets like [CupertinoSegmentedControl]
  /// ```dart
  /// ['Foo', 'Bar', 'Baz'].mappedChildren((e) => Text(e))
  /// returns:
  /// {
  ///   'Foo' : Text('Foo'),
  ///   'Foo' : Text('Bar'),
  ///   'Foo' : Text('Baz'),
  /// }
  /// ```
  /// ```dart
  /// CupertinoSegmentedControl(
  ///   ...
  ///   children: children.mappedChildren
  ///   ...
  /// );
  /// ```
  Map<E, Widget> asMapBuilder(Widget Function(E element) builder) =>
      {for (int i = 0; i < length; i++) elementAt(i): builder(elementAt(i))};

  /// Same as [single] but does not throw [StateError], instead returns null
  E? get singleOrNull => length == 1 ? single : null;
}

extension IterableIterableX<E> on Iterable<Iterable<E>> {
  /// More straightforward solution than [expand] in case of all sub-elements
  /// have same type
  Iterable<E> from2D() sync* {
    for (final sub in this) {
      yield* sub;
    }
  }
}

typedef _ToDateTimeIter<E> = DateTime Function(E e);

extension ChronoIterableX<E> on Iterable<E> {
  E earliest(_ToDateTimeIter<E> toDateTime) => _first(toDateTime, true);

  E latest(_ToDateTimeIter<E> toDateTime) => _first(toDateTime, false);

  E _first(_ToDateTimeIter<E> toDateTime, [bool ascending = true]) {
    final iter = iterator;
    if (!iter.moveNext()) {
      throw StateError('no element found in $this');
    }

    E element = iter.current;
    DateTime dateTime = toDateTime(element);

    while (iter.moveNext()) {
      final currentDateTime = toDateTime(iter.current);
      if (ascending) {
        if (currentDateTime.isBefore(dateTime)) {
          element = iter.current;
          dateTime = currentDateTime;
        }
      } else {
        if (currentDateTime.isAfter(dateTime)) {
          element = iter.current;
          dateTime = currentDateTime;
        }
      }
    }
    return element;
  }
}
