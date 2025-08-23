import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/error.dart';
import 'package:we_repkg/utils/tool.dart';
import 'package:we_repkg/widgets/dialog.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(this.errors, this.cancelFunc, {super.key});

  final List<ErrorInfo> errors;
  final void Function() cancelFunc;

  @override
  Widget build(BuildContext context) {
    return DialogView(
      title: tr(AppI10n.dialogErrorTitle),
      content: ListView.separated(
        itemCount: errors.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          ErrorInfo err = errors[index];
          if (err.wallpaper == null) {
            List<String> texts = splitOnFirstColon(err.message);
            return ErrorTextInfo(title: texts.first, label: texts.last);
          }

          return Row(
            key: ValueKey(index),
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[200],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.file(
                  File(err.wallpaper!.previews),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: frame != null
                              ? child
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        );
                      },
                ),
              ),
              Expanded(
                child: ErrorTextInfo(
                  title: err.wallpaper!.title,
                  label: err.message,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
      ),
      onClose: () => cancelFunc(),
    );
  }
}

class ErrorTextInfo extends StatelessWidget {
  const ErrorTextInfo({super.key, required this.title, required this.label});
  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label.trim(),
            style: theme.textTheme.bodyMedium,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
