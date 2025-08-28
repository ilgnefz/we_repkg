import 'package:flutter/material.dart';
import 'package:we_repkg/widgets/icon_btn.dart';

import 'custom_input.dart';

class FolderInput extends StatelessWidget {
  const FolderInput({
    super.key,
    this.width,
    this.height,
    required this.controller,
    this.fontSize,
    required this.hintText,
    required this.onPressed,
  });

  final double? width;
  final double? height;
  final TextEditingController controller;
  final double? fontSize;
  final String hintText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      width: width,
      height: height,
      controller: controller,
      padding: EdgeInsets.only(left: 8),
      fontSize: fontSize,
      readOnly: true,
      hintText: hintText,
      extraIcon: Container(
        width: 1,
        height: 20,
        color: Theme.of(context).dividerColor,
      ),
      suffix: IconBtn(icon: Icons.folder_open_rounded, onPressed: onPressed),
      // onPressed: onPressed,
    );
  }
}
