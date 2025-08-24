import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:we_repkg/constants/i10n.dart';

enum RunState { initial, empty, complete }

extension RunStateExtension on RunState {
  bool get isInitial => this == RunState.initial;
  bool get isEmpty => this == RunState.empty;
  // bool get isLoading => this == RunState.loading;
  bool get isComplete => this == RunState.complete;
}

enum SortType { time, size, update }

extension SortTypeExtension on SortType {
  String get label {
    switch (this) {
      case SortType.time:
        return tr(AppI10n.homeSortDate);
      case SortType.size:
        return tr(AppI10n.homeSortSize);
      case SortType.update:
        return tr(AppI10n.homeSortUpdate);
    }
  }
}

enum LanguageType { en, zh }

extension LanguageTypeExtension on LanguageType {
  String get label {
    switch (this) {
      case LanguageType.en:
        return 'English';
      case LanguageType.zh:
        return '中文';
    }
  }

  Locale get locale {
    switch (this) {
      case LanguageType.en:
        return const Locale('en', 'US');
      case LanguageType.zh:
        return const Locale('zh', 'CN');
    }
  }

  bool get isEnglish => this == LanguageType.en;
  bool get isChinese => this == LanguageType.zh;
}

enum ThemeType { light, dark, system }

extension ThemeTypeExtension on ThemeType {
  String get label {
    switch (this) {
      case ThemeType.light:
        return tr(AppI10n.settingSystemLight);
      case ThemeType.dark:
        return tr(AppI10n.settingSystemDark);
      case ThemeType.system:
        return tr(AppI10n.settingSystemSystem);
    }
  }

  ThemeMode get mode {
    switch (this) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
      case ThemeType.system:
        return ThemeMode.system;
    }
  }
}

enum MatureState { show, hide, only }

extension MatureStateExtension on MatureState {
  String get label {
    switch (this) {
      case MatureState.only:
        return tr(AppI10n.settingFilterOnly);
      case MatureState.show:
        return tr(AppI10n.settingFilterShow);
      case MatureState.hide:
        return tr(AppI10n.settingFilterHide);
    }
  }

  bool get isOnly => this == MatureState.only;
  bool get isShow => this == MatureState.show;
  bool get isHide => this == MatureState.hide;
}

enum NotificationType { system, app }

extension NotificationTypeExtension on NotificationType {
  String get label {
    switch (this) {
      case NotificationType.system:
        return tr(AppI10n.settingSystemInSystem);
      case NotificationType.app:
        return tr(AppI10n.settingSystemInApp);
    }
  }

  bool get isSystem => this == NotificationType.system;
  bool get isApp => this == NotificationType.app;
}
