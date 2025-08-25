import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/models/error.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/utils/storage.dart';
import 'package:we_repkg/views/states/error.dart';
import 'package:we_repkg/views/states/loading.dart';
import 'package:we_repkg/widgets/toast.dart';

void showSelectFolderToast(String message) {
  BotToast.showCustomText(
    duration: Duration(seconds: 5),
    toastBuilder: (void Function() cancelFunc) {
      return ToastView(
        icon: Icons.lightbulb_circle_rounded,
        iconColor: Colors.blue,
        text: message,
      );
    },
  );
}

void showCopyToast() {
  BotToast.showCustomText(
    duration: Duration(seconds: 3),
    toastBuilder: (void Function() cancelFunc) {
      return ToastView(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        text: tr(AppI10n.dialogCopySuccess),
      );
    },
  );
}

void showExtractSuccessToast() {
  int index = StorageUtil.getInt(AppKeys.notificationType) ?? 1;
  if (index == 1) {
    BotToast.showCustomText(
      duration: Duration(seconds: 3),
      toastBuilder: (void Function() cancelFunc) {
        return ToastView(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          text: tr(AppI10n.dialogOperationCompleted),
        );
      },
    );
    return;
  }
  LocalNotification notification = LocalNotification(
    title: tr(AppI10n.dialogOperationCompleted),
  );
  notification.show();
}

void showToolNoExistToast() {
  BotToast.showCustomText(
    duration: Duration(seconds: 5),
    toastBuilder: (void Function() cancelFunc) {
      return ToastView(
        icon: Icons.warning_rounded,
        iconColor: Colors.red,
        text: tr(AppI10n.toolNoExist),
      );
    },
  );
}

void showErrorToast(String message) {
  BotToast.showCustomText(
    duration: Duration(seconds: 5),
    toastBuilder: (void Function() cancelFunc) {
      return ToastView(
        icon: Icons.warning_rounded,
        iconColor: Colors.red,
        text: message,
      );
    },
  );
}

CancelFunc showLoadingView(List<WallpaperInfo> list) {
  return BotToast.showCustomLoading(
    backgroundColor: Colors.black.withValues(alpha: .6),
    toastBuilder: (void Function() cancelFunc) => LoadingView(list),
  );
}

void showErrorView(List<ErrorInfo> errList) {
  BotToast.showCustomLoading(
    backgroundColor: Colors.black.withValues(alpha: .6),
    toastBuilder: (void Function() cancelFunc) =>
        ErrorView(errList, cancelFunc),
  );
}
