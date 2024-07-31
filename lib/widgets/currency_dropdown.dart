import 'package:flutter/material.dart';
import 'package:conversor_de_moeda/models/currency.dart';
import 'package:conversor_de_moeda/widgets/currency_dropdown_item.dart';
import 'package:conversor_de_moeda/widgets/custom_dropdown_button.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({
    super.key,
    required this.onChange,
    required this.label,
    required this.currenciesList,
  });

  final Function(Currency) onChange;
  final List<Currency> currenciesList;
  final String label;

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  Currency? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<Currency>(
      label: widget.label,
      value: _selectedValue,
      hint: "Select",
      items: widget.currenciesList
          .map((c) => DropdownMenuItem<Currency>(
                value: c,
                child: CurrencyDropdownItem(currency: c),
              ))
          .toList(),
      onChanged: (Currency? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        if (newValue != null) {
          widget.onChange(newValue);
        }
      },
    );
  }
}
