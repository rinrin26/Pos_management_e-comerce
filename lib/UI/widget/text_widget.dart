import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextWidget({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodySmall,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
