import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? buttonColor, borderColor, iconColor, textColor;
  final IconData? icon;
  final String? imgUrl;
  final double? fontSize;

  final double? iconSize, btnWidth, btnHeight;

  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.textStyle,
      this.buttonColor,
      this.borderColor = Colors.transparent,
      this.icon,
      this.iconColor,
      this.iconSize,
      this.btnWidth = 360,
      this.btnHeight = 60,
      this.textColor = Colors.black,
      this.imgUrl, this.fontSize = 20});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Colors.white,
          textStyle: textStyle,
          side: BorderSide(color: borderColor!, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: iconSize ?? 24.0,
              ),
            // if (icon != null) const SizedBox(width: 8),
             if (imgUrl != null)
              Image.network(
                imgUrl!,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
            //  if (imgUrl != null) const SizedBox(width: 8),
            if (icon != null && imgUrl != null) const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(fontSize: fontSize!, color: textColor!),
            ),
          ],
        ),
      ),
    );
  }
}
