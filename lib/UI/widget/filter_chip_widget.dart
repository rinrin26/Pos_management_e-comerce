import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Function(bool)? onSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  const FilterChipWidget({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.white,
    this.selectedTextStyle,
    this.unselectedTextStyle,
  });

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.label,
        style: _isSelected
            ? widget.selectedTextStyle ?? const TextStyle(color: Colors.white)
            : widget.unselectedTextStyle ??
                const TextStyle(color: Colors.black),
      ),
      selected: _isSelected,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
        if (widget.onSelected != null) {
          widget.onSelected!(selected);
        }
      },
      selectedColor: widget.selectedColor,
      backgroundColor: widget.unselectedColor,
      showCheckmark: false,
    );
  }
}
