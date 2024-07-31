abstract class CurrencyEvent {
  const CurrencyEvent();
}

class FetchCurrenciesEvent extends CurrencyEvent {}

class FetchConversionRate extends CurrencyEvent {
  final String from;
  final String to;
  final double amount;

  const FetchConversionRate(this.from, this.to, this.amount);
}

class SelectCurrency extends CurrencyEvent {
  final String currency;

  const SelectCurrency(this.currency);
}
