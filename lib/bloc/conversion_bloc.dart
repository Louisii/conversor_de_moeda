import 'package:conversor_de_moeda/bloc/conversion_event.dart';
import 'package:conversor_de_moeda/bloc/conversion_state.dart';
import 'package:conversor_de_moeda/models/currency.dart';
import 'package:conversor_de_moeda/repositories/conversion_repository.dart';
import 'package:conversor_de_moeda/models/conversion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversionBloc extends Bloc<ConversionEvent, ConversionState> {
  final ConversionRepository _conversionRepository = ConversionRepository();

  ConversionBloc() : super(ConversionInitialState()) {
    on<CalculateConversionResultEvent>(_onCalculateConversionResult);
    on<SetFromCurrencyEvent>(_onSetFromCurrencyEvent);
    on<SetToCurrencyEvent>(_onSetToCurrencyEvent);
    on<SetFromCurrencyAmountEvent>(_onSetFromCurrencyAmountEvent);
  }

  Future<void> _onCalculateConversionResult(
      CalculateConversionResultEvent event,
      Emitter<ConversionState> emit) async {
    await _fetchConversionRateAndEmit(
      event.fromCurrency,
      event.toCurrency,
      event.amount,
      emit,
    );
  }

  Future<void> _onSetFromCurrencyAmountEvent(
      SetFromCurrencyAmountEvent event, Emitter<ConversionState> emit) async {
    if (state is ConversionSuccessState) {
      final currentState = state as ConversionSuccessState;
      final updatedConversion =
          currentState.conversion?.copyWith(amount: event.fromCurrencyAmount);

      emit(ConversionSuccessState(conversion: updatedConversion));
      await _tryFetchConversionRate(updatedConversion, emit);
    } else {
      final updatedConversion = Conversion(amount: event.fromCurrencyAmount);
      emit(ConversionSuccessState(conversion: updatedConversion));
    }
  }

  Future<void> _onSetFromCurrencyEvent(
      SetFromCurrencyEvent event, Emitter<ConversionState> emit) async {
    if (state is ConversionSuccessState) {
      final currentState = state as ConversionSuccessState;
      final updatedConversion =
          currentState.conversion?.copyWith(fromCurrency: event.fromCurrency);

      emit(ConversionSuccessState(conversion: updatedConversion));
      await _tryFetchConversionRate(updatedConversion, emit);
    } else {
      final updatedConversion = Conversion(fromCurrency: event.fromCurrency);
      emit(ConversionSuccessState(conversion: updatedConversion));
    }
  }

  Future<void> _onSetToCurrencyEvent(
      SetToCurrencyEvent event, Emitter<ConversionState> emit) async {
    if (state is ConversionSuccessState) {
      final currentState = state as ConversionSuccessState;
      final updatedConversion =
          currentState.conversion?.copyWith(toCurrency: event.toCurrency);

      emit(ConversionSuccessState(conversion: updatedConversion));
      await _tryFetchConversionRate(updatedConversion, emit);
    } else {
      final updatedConversion = Conversion(toCurrency: event.toCurrency);
      emit(ConversionSuccessState(conversion: updatedConversion));
    }
  }

  Future<void> _tryFetchConversionRate(
      Conversion? conversion, Emitter<ConversionState> emit) async {
    if (conversion?.fromCurrency != null && conversion?.toCurrency != null) {
      await _fetchConversionRateAndEmit(
        conversion!.fromCurrency!,
        conversion.toCurrency!,
        conversion.amount ?? 1.0,
        emit,
      );
    }
  }

  Future<void> _fetchConversionRateAndEmit(Currency fromCurrency,
      Currency toCurrency, double amount, Emitter<ConversionState> emit) async {
    try {
      // emit(ConversionLoadingState());

      final double resultRate = await _conversionRepository.fetchConversionRate(
          fromCurrency.code, toCurrency.code);

      final conversion = Conversion(
        rate: resultRate,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
        result: amount * resultRate,
      );

      emit(ConversionSuccessState(conversion: conversion));
    } catch (e) {
      // emit(ConversionErrorState(error: e.toString()));
    }
  }
}
