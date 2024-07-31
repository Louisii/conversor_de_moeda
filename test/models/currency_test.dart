import 'package:conversor_de_moeda/models/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Currency', () {
    test('should create a Currency instance', () {
      final currency = Currency(code: 'USD', name: 'United States Dollar');

      expect(currency, isA<Currency>());
      expect(currency.code, 'USD');
      expect(currency.name, 'United States Dollar');
    });

    test('should throw an error if code is empty', () {
      expect(() => Currency(code: '', name: 'Invalid Currency'), throwsA(isA<AssertionError>()));
    });

    test('should throw an error if name is empty', () {
      expect(() => Currency(code: 'USD', name: ''), throwsA(isA<AssertionError>()));
    });

    test('should compare currencies correctly', () {
      final currency1 = Currency(code: 'USD', name: 'United States Dollar');
      final currency2 = Currency(code: 'USD', name: 'United States Dollar');
      final currency3 = Currency(code: 'EUR', name: 'Euro');

      expect(currency1, equals(currency2));
      expect(currency1, isNot(equals(currency3)));
    });
  });
}
