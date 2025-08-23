import 'package:flutter/material.dart';

class ClickIcon extends StatelessWidget {
  const ClickIcon({
    super.key,
    required this.icon,
    this.size = 18,
    this.radius,
    this.width,
    this.height,
    this.onTap,
  });

  final IconData icon;
  final double size;
  final double? radius;
  final double? width;
  final double? height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Widget child = Icon(
      icon,
      size: size,
      color: Theme.of(context).iconTheme.color,
    );
    if (width != null && height != null) {
      child = SizedBox(width: width, height: height, child: child);
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(padding: const EdgeInsets.all(4.0), child: child),
    );
  }
}
