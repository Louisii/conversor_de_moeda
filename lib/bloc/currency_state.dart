import 'package:conversor_de_moeda/models/currency.dart';

abstract class CurrencyState {
  List<Currency> currencies;

  CurrencyState({
    required this.currencies,
  });
}

class CurrencyInitialState extends CurrencyState {
  CurrencyInitialState() : super(currencies: []);
}

// class CurrencyLoadInProgress extends CurrencyState {}

class CurrencySuccessState extends CurrencyState {
  CurrencySuccessState({required super.currencies});
}



// class CurrencyLoadFailure extends CurrencyState {}

// class CurrencySelectedState extends CurrencyState {
//   final String selectedCurrency;

//   const CurrencySelectedState(this.selectedCurrency);

//   @override
//   List<Object> get props => [selectedCurrency];
// }
