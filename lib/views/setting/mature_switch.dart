import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/provider/filter.dart';
import 'package:we_repkg/widgets/sliding_switch.dart';

class MatureSwitch extends ConsumerWidget {
  const MatureSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    MatureState type = ref.watch(filterStateProvider).matureState;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(tr(AppI10n.settingFilterHideMature)),
        SlidingSwitch(
          initialValue: type.index,
          children: {
            1: Text(
              MatureState.values[0].label,
              style: theme.textTheme.bodySmall,
            ),
            2: Text(
              MatureState.values[1].label,
              style: theme.textTheme.bodySmall,
            ),
            3: Text(
              MatureState.values[2].label,
              style: theme.textTheme.bodySmall,
            ),
          },
          onValueChanged: (v) => ref
              .read(filterStateProvider.notifier)
              .updateMatureState(MatureState.values[v - 1]),
        ),
      ],
    );
  }
}
