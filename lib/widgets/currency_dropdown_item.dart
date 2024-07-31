import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:conversor_de_moeda/models/currency.dart';

class CurrencyDropdownItem extends StatelessWidget {
  const CurrencyDropdownItem({Key? key, required this.currency})
      : super(key: key);

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem<Currency>(
      value: currency,
      child: Row(
        children: [
          if (currency.pathToSvgFlag != null)
            SvgPicture.asset(
              currency.pathToSvgFlag!,
              width: 20,
            ),
          const SizedBox(
            width: 12,
          ),
          Text(currency.name),
        ],
      ),
    );
  }
}
