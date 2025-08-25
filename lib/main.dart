import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/config/language.dart';
import 'package:we_repkg/config/theme.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/views/home.dart';

import 'config/app.dart';

Future<void> main() async {
  await AppConfig.init([]);
  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: LanguageConfig.path,
        supportedLocales: LanguageConfig.supportedLocales,
        fallbackLocale: LanguageConfig.fallbackLocale,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.watch(currentThemeProvider).mode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: HomeView(),
    );
  }
}
