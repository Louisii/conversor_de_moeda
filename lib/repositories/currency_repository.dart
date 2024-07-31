import 'package:conversor_de_moeda/models/currency.dart';

class CurrencyRepository {
  final List<Currency> _currencies = [];


  List<Currency> fetchCurrencies() {
    _currencies.addAll([
      Currency(
          code: "BRL", name: "BRL", pathToSvgFlag: "assets/icons/flags/br.svg"),
      Currency(
          code: "USD", name: "USD", pathToSvgFlag: "assets/icons/flags/us.svg"),
      Currency(
          code: "EUR", name: "EUR", pathToSvgFlag: "assets/icons/flags/eu.svg"),
      Currency(
          code: "GBP", name: "GBP", pathToSvgFlag: "assets/icons/flags/gb.svg"),
      Currency(
          code: "JPY", name: "JPY", pathToSvgFlag: "assets/icons/flags/jp.svg"),
      Currency(
          code: "AUD", name: "AUD", pathToSvgFlag: "assets/icons/flags/au.svg"),
    ]);

    return _currencies;
  }

}
