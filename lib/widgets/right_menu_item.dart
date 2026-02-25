import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

final class RightMenuItem extends ContextMenuItem {
  final String label;
  final Color? color;

  const RightMenuItem({
    required this.label,
    this.color,
    super.value,
    super.onSelected,
    super.enabled,
  });

  const RightMenuItem.submenu({
    required this.label,
    this.color,
    required List<ContextMenuEntry> items,
    super.onSelected,
    super.enabled,
  }) : super.submenu(items: items);

  @override
  Widget builder(
    BuildContext context,
    ContextMenuState menuState, [
    FocusNode? focusNode,
  ]) {
    final ThemeData theme = Theme.of(context);
    bool isFocused = menuState.focusedEntry == this;
    final Color background =
        theme.dialogTheme.backgroundColor ?? theme.scaffoldBackgroundColor;
    final Color focusedBackground = Colors.grey.withValues(alpha: 0.2);
    final TextStyle textStyle = TextStyle(
      color: color ?? theme.textTheme.labelMedium?.color,
      height: 1.0,
      fontSize: 14.0,
      fontFamily: 'Microsoft YaHei',
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 36.0, minWidth: 120.0),
      child: Material(
        color: !enabled
            ? Colors.transparent
            : isFocused
            ? focusedBackground
            : background,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: !enabled ? null : () => handleItemSelection(context),
          mouseCursor: SystemMouseCursors.click,
          canRequestFocus: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(
              label,
              maxLines: 1,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  @override
  String get debugLabel => "[${hashCode.toString().substring(0, 5)}] $label";
}
