import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInputField extends StatefulWidget {
  AmountInputField({
    Key? key,
    required this.onChange,
    required this.label,
  }) : super(key: key);

  final Function(String) onChange;
  final String label;

  @override
  _AmountInputFieldState createState() => _AmountInputFieldState();
}

class _AmountInputFieldState extends State<AmountInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _hintText = '1.00';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_formatInput);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_formatInput);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _controller.text.isEmpty) {
      setState(() {
        _hintText = '1.00';
      });
    } else {
      _formatInput();
      _hintText = '';
    }
  }

  void _formatInput() {
    String text = _controller.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.isNotEmpty) {
      double value = double.parse(text) / 100;
      String formattedText = value.toStringAsFixed(2);
      _controller.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else if (_focusNode.hasFocus) {
      // Show empty if has focus
      _controller.value = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
  }

  void _clearField() {
    _controller.clear();
    setState(() {
      _hintText = '00.00';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              widget.label,
              style: theme.textTheme.titleSmall,
            ),
          ),
          TextField(
            onChanged: (text) {
              widget.onChange(text);
            },
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: _hintText,
              suffixIcon: _controller.text.isEmpty
                  ? Icon(Icons.monetization_on, color: theme.primaryColor)
                  : IconButton(
                      icon: Icon(Icons.clear, color: theme.primaryColor),
                      onPressed: _clearField,
                    ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ],
      ),
    );
  }
}
