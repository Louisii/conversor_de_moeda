import 'package:conversor_de_moeda/bloc/conversion_bloc.dart';
import 'package:conversor_de_moeda/bloc/conversion_event.dart';
import 'package:conversor_de_moeda/bloc/conversion_state.dart';
import 'package:conversor_de_moeda/bloc/currency_bloc.dart';
import 'package:conversor_de_moeda/bloc/currency_event.dart';
import 'package:conversor_de_moeda/bloc/currency_state.dart';
import 'package:conversor_de_moeda/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/amount_input_field.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/frosted_glass_card.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  late final CurrencyBloc currencyBloc;
  late final ConversionBloc conversionBloc;

  @override
  void initState() {
    super.initState();
    currencyBloc = CurrencyBloc();
    currencyBloc.add(FetchCurrenciesEvent());
    conversionBloc = ConversionBloc();
  }

  @override
  void dispose() {
    currencyBloc.close();
    conversionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyBloc()..add(FetchCurrenciesEvent()),
      child: BlocProvider(
        create: (context) => ConversionBloc(),
        child: Scaffold(
          appBar: null,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg/bg2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: BlocBuilder<CurrencyBloc, CurrencyState>(
                        builder: (context, state) {
                      if (state is CurrencyInitialState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CurrencySuccessState) {
                        final currenciesList = state.currencies;

                        return Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                FrostedGlassCard(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BlocBuilder<ConversionBloc,
                                                  ConversionState>(
                                              builder: (context, state) {
                                            return CurrencyDropdown(
                                              label: "From currency",
                                              currenciesList: currenciesList,
                                              onChange: (selectedCurrency) {
                                                context
                                                    .read<ConversionBloc>()
                                                    .add(
                                                      SetFromCurrencyEvent(
                                                        fromCurrency:
                                                            selectedCurrency,
                                                      ),
                                                    );
                                              },
                                            );
                                          }),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          BlocBuilder<ConversionBloc,
                                                  ConversionState>(
                                              bloc: conversionBloc,
                                              builder: (context, state) {
                                                return AmountInputField(
                                                  label: "Amount",
                                                  onChange:
                                                      (fromCurrencyAmount) {
                                                    context
                                                        .read<ConversionBloc>()
                                                        .add(
                                                          SetFromCurrencyAmountEvent(
                                                            fromCurrencyAmount:
                                                                double.parse(
                                                                    fromCurrencyAmount),
                                                          ),
                                                        );
                                                  },
                                                );
                                              }),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BlocBuilder<ConversionBloc,
                                                  ConversionState>(
                                              builder: (context, state) {
                                            return CurrencyDropdown(
                                              label: "To currency",
                                              currenciesList: currenciesList,
                                              onChange: (selectedCurrency) {
                                                context
                                                    .read<ConversionBloc>()
                                                    .add(
                                                      SetToCurrencyEvent(
                                                        toCurrency:
                                                            selectedCurrency,
                                                      ),
                                                    );
                                              },
                                            );
                                          }),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          BlocBuilder<ConversionBloc,
                                                  ConversionState>(
                                              builder: (context, state) {
                                            if (state
                                                    is ConversionSuccessState &&
                                                state.conversion?.result !=
                                                    null) {
                                              return Text(state
                                                  .conversion!.result!
                                                  .toStringAsFixed(2));
                                            } else {
                                              return const Text('result');
                                            }
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
