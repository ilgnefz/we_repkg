import 'package:flutter/material.dart';
import 'package:we_repkg/config/custom_theme.dart';

class ToastView extends StatelessWidget {
  const ToastView({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  final IconData icon;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).extension<ToastTheme>()?.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Row(
            spacing: 8,
            children: [
              Icon(icon, color: iconColor),
              Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
