import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/provider/setting.dart';

class SortDropdown extends ConsumerStatefulWidget {
  const SortDropdown({super.key});

  @override
  ConsumerState<SortDropdown> createState() => _TopSortState();
}

class _TopSortState extends ConsumerState<SortDropdown> {
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          focusNode: focusNode,
          value: ref.watch(wallpaperSortTypeProvider),
          isDense: true,
          padding: EdgeInsets.only(left: 8, top: 6, bottom: 6),
          borderRadius: BorderRadius.circular(4),
          dropdownColor: Theme.of(
            context,
          ).dropdownMenuTheme.inputDecorationTheme?.fillColor,
          focusColor: Colors.transparent,
          items: SortType.values
              .map((e) {
                bool useAcfFile = ref.watch(useAcfInfoProvider);
                if (!useAcfFile && e == SortType.update) return null;
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.label,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 13),
                  ),
                );
              })
              .whereType<DropdownMenuItem<SortType>>()
              .toList(),
          onChanged: (value) {
            ref.read(wallpaperSortTypeProvider.notifier).update(value!);
            focusNode.unfocus();
            setState(() {});
          },
        ),
      ),
    );
  }
}
