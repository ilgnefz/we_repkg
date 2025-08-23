import 'package:flutter/material.dart';

class SettingCheckbox extends StatelessWidget {
  const SettingCheckbox({
    super.key,
    this.child,
    this.label,
    required this.value,
    required this.onChanged,
  });

  final Widget? child;
  final String? label;
  final bool value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        child ?? Text(label!, style: Theme.of(context).textTheme.bodyMedium),
        Checkbox(
          value: value,
          onChanged: onChanged,
          side: BorderSide(width: 2, color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.blue
                : Colors.transparent,
          ),
        ),
      ],
    );
  }
}
