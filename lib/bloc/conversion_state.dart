import 'package:conversor_de_moeda/models/conversion.dart';

abstract class ConversionState {
  final Conversion? conversion;

  const ConversionState({
    this.conversion,
  });
}

class ConversionInitialState extends ConversionState {
  ConversionInitialState() : super(conversion: null);
}

class ConversionSuccessState extends ConversionState {
  ConversionSuccessState({
    super.conversion,
  });
}
