import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.width,
    this.height,
    required this.controller,
    this.padding,
    this.fontSize,
    required this.hintText,
    this.leading,
    this.suffix,
    this.readOnly = false,
    this.onPressed,
    this.onChanged,
    this.extraIcon,
  });

  final double? width;
  final double? height;
  final TextEditingController controller;
  final EdgeInsets? padding;
  final double? fontSize;
  final String hintText;
  final Widget? leading;
  final Widget? suffix;
  final bool readOnly;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final Widget? extraIcon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: width,
      height: height ?? 36,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: theme.inputDecorationTheme.fillColor,
      ),
      alignment: Alignment.center,
      child: Row(
        spacing: 4,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: fontSize ?? 14,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: theme.inputDecorationTheme.hintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                // contentPadding: EdgeInsets.symmetric(horizontal: 12),
                isCollapsed: true,
              ),
              onChanged: onChanged,
            ),
          ),
          if (extraIcon != null) extraIcon!,
          if (suffix != null) ...[suffix!, SizedBox.shrink()],
        ],
      ),
    );
  }
}
