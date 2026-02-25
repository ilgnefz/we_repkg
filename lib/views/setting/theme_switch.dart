import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/widgets/sliding_switch.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ThemeType type = ref.watch(currentThemeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(tr(AppI10n.settingSystemTheme)),
        SlidingSwitch(
          initialValue: type.index,
          children: {
            1: Text(
              ThemeType.values[0].label,
              style: theme.textTheme.bodySmall,
            ),
            2: Text(
              ThemeType.values[1].label,
              style: theme.textTheme.bodySmall,
            ),
            3: Text(
              ThemeType.values[2].label,
              style: theme.textTheme.bodySmall,
            ),
          },
          onValueChanged: (v) => ref
              .read(currentThemeProvider.notifier)
              .update(ThemeType.values[v - 1]),
        ),
      ],
    );
  }
}
