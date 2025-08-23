import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/widgets/icon_btn.dart';

class SortToggle extends ConsumerWidget {
  const SortToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconBtn(
      onPressed: ref.read(sortAscendingProvider.notifier).update,
      icon: ref.watch(sortAscendingProvider)
          ? Icons.arrow_upward_rounded
          : Icons.arrow_downward_rounded,
    );
  }
}
