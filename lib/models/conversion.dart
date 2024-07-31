import 'package:conversor_de_moeda/models/currency.dart';

class Conversion {
  final double? rate;
  final Currency? fromCurrency;
  final Currency? toCurrency;
  final double? amount;
  final double? result;

  Conversion(
      {this.rate,
      this.fromCurrency,
      this.toCurrency,
      this.amount,
      this.result});

  Conversion copyWith({
    double? rate,
    Currency? fromCurrency,
    Currency? toCurrency,
    double? amount,
    double? result,
  }) {
    return Conversion(
      rate: rate ?? this.rate,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      result: result ?? this.result,
    );
  }
}
