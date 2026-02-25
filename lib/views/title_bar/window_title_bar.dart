import 'package:flutter/material.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/views/title_bar/setting.dart';
import 'package:we_repkg/views/title_bar/window_btn_group.dart';
import 'package:window_manager/window_manager.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: SizedBox(
        height: 32.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Image.asset('assets/images/logo.png', width: 20, height: 20),
            SizedBox(width: 4),
            Text(
              AppStrings.appName,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontSize: 13),
            ),
            Spacer(),
            SettingBtn(),
            WindowBtnGroup(),
          ],
        ),
      ),
    );
  }
}
