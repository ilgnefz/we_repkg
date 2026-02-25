import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/widgets/sliding_switch.dart';

class NotificationSwitch extends ConsumerWidget {
  const NotificationSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    NotificationType type = ref.watch(localNotificationTypeProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(tr(AppI10n.settingSystemNotification)),
        SlidingSwitch(
          initialValue: type.index,
          children: {
            1: Text(
              NotificationType.values[0].label,
              style: theme.textTheme.bodySmall,
            ),
            2: Text(
              NotificationType.values[1].label,
              style: theme.textTheme.bodySmall,
            ),
          },
          onValueChanged: (v) => ref
              .read(localNotificationTypeProvider.notifier)
              .update(NotificationType.values[v - 1]),
        ),
      ],
    );
  }
}
