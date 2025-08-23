import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:we_repkg/constants/i10n.dart';

class DialogView extends StatelessWidget {
  const DialogView({
    super.key,
    required this.title,
    required this.content,
    required this.onClose,
  });

  final String title;
  final Widget content;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return UnconstrainedBox(
      child: Material(
        elevation: 16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Theme.of(context).dialogTheme.backgroundColor,
        child: Container(
          width: 600,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .9,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 48,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                ),
              ),
              Flexible(child: content),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onClose,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tr(AppI10n.close),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
