import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String hint;
  final String label;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const CustomDropdownButton({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint = '',
    required this.label,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.borderRadius,
  });

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.label,
            style: theme.textTheme.titleSmall,
          ),
        ),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white.withOpacity(0.6),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 0.2),
          ),
          child: DropdownButton<T>(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            value: widget.value,
            onChanged: widget.onChanged,
            items: widget.items,
            hint: Text(widget.hint),
            icon: Icon(Icons.arrow_drop_down, color: widget.iconColor),
            iconSize: widget.iconSize ?? 40,
            underline: const SizedBox(),
          ),
        ),
      ],
    );
  }
}
