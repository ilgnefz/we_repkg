import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/widgets/custom_input.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController()
      ..addListener(() {
        setState(() {});
        ref.read(searchContentProvider.notifier).update(controller.text);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: CustomInput(
        controller: controller,
        hintText: tr(AppI10n.homeSearchTip),
        padding: EdgeInsets.only(left: 8, right: 8),
        leading: Icon(Icons.search_rounded, size: 20, color: Colors.grey),
        extraIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: () => setState(() => controller.clear()),
                icon: Icon(Icons.close_rounded),
                iconSize: 16,
                color: Colors.grey,
                padding: EdgeInsets.all(4),
                constraints: BoxConstraints(maxWidth: 36, maxHeight: 36),
              ),
        onChanged: (value) {},
      ),
    );
  }
}
