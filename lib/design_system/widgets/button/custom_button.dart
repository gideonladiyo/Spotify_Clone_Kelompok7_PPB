import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? elevation;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    this.icon,
    this.iconColor,
    this.iconSize = 24.0,
    this.elevation = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, 
        backgroundColor: color,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        elevation: elevation,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? textColor,
              size: iconSize,
            ),
          if (icon != null)
            const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
