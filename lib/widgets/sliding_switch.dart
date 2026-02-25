import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:we_repkg/config/custom_theme.dart';

class SlidingSwitch extends StatelessWidget {
  const SlidingSwitch({
    super.key,
    required this.initialValue,
    required this.children,
    required this.onValueChanged,
  });

  final int initialValue;
  final Map<int, Widget> children;
  final void Function(int) onValueChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CustomSlidingSegmentedControl<int>(
      height: 32,
      initialValue: initialValue + 1,
      children: children,
      customSegmentSettings: CustomSegmentSettings(
        mouseCursor: SystemMouseCursors.click,
      ),
      decoration: BoxDecoration(
        color: theme.extension<SlidingSegmentedTheme>()!.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      thumbDecoration: BoxDecoration(
        color: theme.extension<SlidingSegmentedTheme>()!.foregroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: onValueChanged,
    );
  }
}
