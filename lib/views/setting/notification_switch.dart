import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/config/custom_theme.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/provider/setting.dart';

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
        CustomSlidingSegmentedControl<int>(
          height: 32,
          initialValue: type.index + 1,
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
          onValueChanged: (v) => ref
              .read(localNotificationTypeProvider.notifier)
              .update(NotificationType.values[v - 1]),
        ),
      ],
    );
  }
}
