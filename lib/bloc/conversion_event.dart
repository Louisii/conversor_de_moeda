import 'package:conversor_de_moeda/models/currency.dart';

abstract class ConversionEvent {}

class SetFromCurrencyEvent extends ConversionEvent {
  final Currency fromCurrency;
  SetFromCurrencyEvent({required this.fromCurrency});
}

class SetToCurrencyEvent extends ConversionEvent {
  final Currency toCurrency;
  SetToCurrencyEvent({required this.toCurrency});
}

class SetFromCurrencyAmountEvent extends ConversionEvent {
  final double fromCurrencyAmount;
  SetFromCurrencyAmountEvent({required this.fromCurrencyAmount});
}

class SetToCurrencyResultEvent extends ConversionEvent {
  final double toCurrencyResult;
  SetToCurrencyResultEvent({required this.toCurrencyResult});
}

class CalculateConversionResultEvent extends ConversionEvent {
  final Currency fromCurrency;
  final Currency toCurrency;
  final double amount;

  CalculateConversionResultEvent({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });
}
