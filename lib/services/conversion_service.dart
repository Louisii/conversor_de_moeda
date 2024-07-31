import 'package:conversor_de_moeda/models/conversion.dart';

class ConversionService {
  Conversion conversion;
  ConversionService({required this.conversion});

  Conversion calculateConversion() {
    double result = conversion.amount! * conversion.rate!;
    return Conversion(
      rate: conversion.rate,
      fromCurrency: conversion.fromCurrency,
      toCurrency: conversion.toCurrency,
      amount: conversion.amount,
      result: result,
    );
  }
}
