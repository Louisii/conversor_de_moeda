import 'dart:ui';

import 'package:conversor_de_moeda/bloc/currency_bloc.dart';
import 'package:conversor_de_moeda/repositories/currency_repository.dart';
import 'package:conversor_de_moeda/screens/currency_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFFA3C2DC);

    final theme = Theme.of(context);
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        scaffoldBackgroundColor: mainColor,
        textTheme:
            TextTheme(titleSmall: TextStyle(color: Colors.grey.shade700)),
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor).copyWith(
          surface: Colors.grey.shade700,
          // surface: Color.fromARGB(255, 55, 115, 164),
          primary: mainColor,
          onPrimary: Colors.white,
          inversePrimary: mainColor.withOpacity(0.6),
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.white.withOpacity(0.6),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white, width: 0.2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white, width: 0.2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white, width: 0.2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
      home: const CurrencyConverterScreen(),
      // home: BlocProvider(
      //   create: (context) => CurrencyBloc(CurrencyRepository()),
      //   child: const CurrencyConverterScreen(),
      // ),
    );
  }
}
