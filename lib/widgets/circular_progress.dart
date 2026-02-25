import 'package:flutter/material.dart';

class EasyCircularProgress extends StatelessWidget {
  const EasyCircularProgress({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    Widget child = CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
    );
    if (size == null) return child;
    return SizedBox(width: size, height: size, child: child);
  }
}
