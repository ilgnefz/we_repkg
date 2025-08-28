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
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .9,
        ),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).extension<ToastTheme>()?.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Icon(icon, color: iconColor),
                Flexible(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
