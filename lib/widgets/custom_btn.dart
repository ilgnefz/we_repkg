import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.label,
    this.onPressed,
    this.expended = false,
    this.backgroundColor,
    this.fixedSize,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expended;
  final Color? backgroundColor;
  final Size? fixedSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        minimumSize: expended ? const Size(double.infinity, 40) : null,
        fixedSize: fixedSize,
        enabledMouseCursor: SystemMouseCursors.click,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: onPressed == null ? Colors.grey : Colors.white,
          fontSize: 14,
          fontFamily: 'Microsoft YaHei',
        ),
      ),
    );
  }
}
