
import 'package:conversor_de_moeda/bloc/currency_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_bloc.dart';

class ConvertButton extends StatelessWidget {
  const ConvertButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final bloc = BlocProvider.of<CurrencyBloc>(context);
        bloc.add(
            const FetchConversionRate('USD', 'EUR', 100)); // Exemplo de valores
      },
      child: const Text('Convert'),
    );
  }
}
