import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({super.key, this.icon, this.onPressed});

  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 16,
      padding: EdgeInsets.all(4),
      constraints: BoxConstraints(maxWidth: 36, maxHeight: 36),
      icon: Icon(icon, color: Colors.grey, size: 20),
    );
  }
}
