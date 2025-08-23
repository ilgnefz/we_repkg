import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_repkg/cores/toast.dart';
import 'package:we_repkg/widgets/click_icon.dart';

class CopyBtn extends StatelessWidget {
  const CopyBtn({super.key, required this.text, this.size = 16});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: ClickIcon(
        icon: Icons.copy_outlined,
        size: size,
        onTap: () {
          Clipboard.setData(ClipboardData(text: text));
          showCopyToast();
        },
      ),
    );
  }
}
