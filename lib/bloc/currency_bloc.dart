import 'package:conversor_de_moeda/bloc/currency_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'currency_state.dart';
import '../repositories/currency_repository.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository _currencyRepository = CurrencyRepository();

  CurrencyBloc() : super(CurrencyInitialState()) {
    on<FetchCurrenciesEvent>(
      (event, emit) => emit(CurrencySuccessState(
          currencies: _currencyRepository.fetchCurrencies())),
    );
  }
}
