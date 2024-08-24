import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? textPrefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon, prefixIconText, suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final double? width, height;
  final bool usePrimaryDecoration;
  final bool? filled;
  final Color? fillColor;

  const TextFieldWidget({
    super.key,
     this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.width = 360,
    this.height = 50,
    this.textPrefixIcon = '',
    this.prefixIconText,
    this.suffixIcon,
    this.usePrimaryDecoration = false,
     this.filled = false, 
     this.fillColor,
  });
// Theme.of(context).textTheme.headlineSmall
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          decoration: usePrimaryDecoration!
              ? inputDecorationPrimary()
              : inputDecorationLabelPrefixIcon()),
    );
  }

  Padding prefixIconPhoneNumber() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 66,
          height: 10,
          decoration: BoxDecoration(
            color: textPrefixIcon != null ? Colors.grey.shade300 : null,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textPrefixIcon!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 4),
              Icon(prefixIconText, size: 20),
            ],
          ),
        ),
      );

  InputDecoration inputDecorationPrimary() => InputDecoration(
        filled: filled,
        fillColor: fillColor,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      );

  InputDecoration inputDecorationLabelPrefixIcon() => InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: textPrefixIcon != null ? prefixIconPhoneNumber() : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
}
