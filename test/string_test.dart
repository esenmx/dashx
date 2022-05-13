import 'package:fluiver/fluiver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('String', () {
    test('capitalize', () {
      expect('', ''.capitalize);
      expect('A', 'a'.capitalize);
      expect('Foo', 'foo'.capitalize);
    });

    test('capitalizeEach', () {
      expect('', ''.capitalizeEach());
      expect('', ''.capitalizeEach('', '-'));
      expect('A', 'a'.capitalizeEach());
      expect('Foo Bar', 'foo bar'.capitalizeEach());
      expect('Foo,Bar', 'foo,,bar'.capitalizeEach(','));
      expect('Foo Bar', 'foo,,bar'.capitalizeEach(',', ' '));
    });

    test('nameAbbreviation - enhancedCapitalize', () {
      expect('', ''.nameAbbreviation());
      expect('Asd', 'asd'.nameAbbreviation());
      expect('John Doe'.nameAbbreviation(), 'J. Doe');
      expect('jOHN doe'.nameAbbreviation(), 'J. Doe');
      expect('j dOE'.nameAbbreviation(), 'J Doe');
      expect('john j dOE'.nameAbbreviation(), 'J. J Doe');
    });

    test('removePrefixOrNull', () {
      expect(null, ''.removePrefixOrNull('foo'));
      expect('', 'foo'.removePrefixOrNull('foo'));
      expect('bar', 'foobar'.removePrefixOrNull('foo'));
    });

    test('mayRemovePrefix', () {
      expect('', ''.mayRemovePrefix('foo'));
      expect('', 'foo'.mayRemovePrefix('foo'));
      expect('bar', 'foobar'.mayRemovePrefix('foo'));
    });

    test('removeSuffixOrNull', () {
      expect(null, ''.removeSuffixOrNull('foo'));
      expect('', 'foo'.removeSuffixOrNull('foo'));
      expect('foo', 'foobar'.removeSuffixOrNull('bar'));
    });

    test('mayRemoveSuffix', () {
      expect('', ''.mayRemoveSuffix('foo'));
      expect('', 'foo'.mayRemoveSuffix('foo'));
      expect('foo', 'foobar'.mayRemoveSuffix('bar'));
    });
  });
}
