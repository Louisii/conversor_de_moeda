import 'package:conversor_de_moeda/bloc/conversion_event.dart';
import 'package:conversor_de_moeda/bloc/conversion_state.dart';
import 'package:conversor_de_moeda/repositories/conversion_repository.dart';
import 'package:conversor_de_moeda/models/conversion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversionBloc extends Bloc<ConversionEvent, ConversionState> {
  final ConversionRepository _conversionRepository = ConversionRepository();

  ConversionBloc() : super(ConversionInitialState()) {
    on<CalculateConversionResultEvent>(_onCalculateConversionResult);

    on<SetFromCurrencyEvent>(_onSetFromCurrencyEvent);
    on<SetToCurrencyEvent>(_onSetToCurrencyEvent);
  }

  void _onSetToCurrencyEvent(
      SetToCurrencyEvent event, Emitter<ConversionState> emit) {
    if (state is ConversionSuccessState) {
      final currentState = state as ConversionSuccessState;
      emit(ConversionSuccessState(
        conversion:
            currentState.conversion?.copyWith(toCurrency: event.toCurrency),
      ));
    } else {
      emit(ConversionSuccessState(
        conversion: Conversion(toCurrency: event.toCurrency),
      ));
    }
  }

  void _onSetFromCurrencyEvent(
      SetFromCurrencyEvent event, Emitter<ConversionState> emit) {
    if (state is ConversionSuccessState) {
      final currentState = state as ConversionSuccessState;
      emit(ConversionSuccessState(
        conversion:
            currentState.conversion?.copyWith(fromCurrency: event.fromCurrency),
      ));
    } else {
      emit(ConversionSuccessState(
        conversion: Conversion(fromCurrency: event.fromCurrency),
      ));
    }
  }

  Future<void> _onCalculateConversionResult(
      CalculateConversionResultEvent event,
      Emitter<ConversionState> emit) async {
    // emit(ConversionLoadingState());

    // try {
    final conversionWithRate = await _conversionRepository.fetchConversionRate(
        event.fromCurrency.code, event.toCurrency.code);

    final conversion = Conversion(
      rate: conversionWithRate.rate,
      fromCurrency: event.fromCurrency,
      toCurrency: event.toCurrency,
      amount: event.amount,
    );

    emit(ConversionSuccessState(conversion: conversion));
    // }
    // catch (e) {
    //   emit(ConversionErrorState(error: e.toString()));
    // }
  }
}
