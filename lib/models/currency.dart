class Currency {
  final String code;
  final String name;
  final String? pathToSvgFlag;

  Currency({required this.code, required this.name, this.pathToSvgFlag})
      : assert(code.isNotEmpty, 'Code must not be empty'),
        assert(name.isNotEmpty, 'Name must not be empty');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency && other.code == code && other.name == name;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;
}
