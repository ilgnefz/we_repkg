import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/widgets/sliding_switch.dart';

class LanguageSwitch extends ConsumerWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    Locale locale = context.locale;
    int index = locale == Locale('zh', 'CN') ? 1 : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(tr(AppI10n.settingSystemLanguage)),
        SlidingSwitch(
          initialValue: index,
          children: {
            1: Text(
              LanguageType.values[0].label,
              style: theme.textTheme.bodySmall,
            ),
            2: Text(
              LanguageType.values[1].label,
              style: theme.textTheme.bodySmall,
            ),
          },
          onValueChanged: (v) {
            context.setLocale(LanguageType.values[v - 1].locale);
          },
        ),
      ],
    );
  }
}
