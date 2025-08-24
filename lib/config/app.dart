import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/src/rust/frb_generated.dart';
import 'package:we_repkg/utils/pack.dart';
import 'package:we_repkg/utils/storage.dart';
import 'package:window_manager/window_manager.dart';

class AppConfig {
  static init(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();
    await RustLib.init();
    await PackInfo.init();
    await StorageUtil.init();
    await EasyLocalization.ensureInitialized();
    await windowManager.ensureInitialized();

    await StorageUtil.clear();

    await localNotifier.setup(
      appName: AppStrings.appName,
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );

    WindowOptions windowOptions = WindowOptions(
      size: Size(1060, 720),
      minimumSize: Size(1060, 720),
      center: true,
      title: AppStrings.appName,
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // await windowManager.maximize();
      await windowManager.show();
      await windowManager.focus();
      // await windowManager.setAsFrameless();
    });
  }
}
