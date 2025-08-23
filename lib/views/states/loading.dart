import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/widgets/ellipsis_animation_text.dart';

class LoadingView extends ConsumerStatefulWidget {
  const LoadingView(this.list, {super.key});

  final List<WallpaperInfo> list;

  @override
  ConsumerState<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends ConsumerState<LoadingView>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<double> _imageAnimation;
  late AnimationController _textController;
  late Animation<double> _textAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  int _previousIndex = -1;

  @override
  void initState() {
    super.initState();
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _imageAnimation = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // List<WallpaperInfo> list = ref.watch(extractListProvider);
    int total = widget.list.length;
    int currentIndex = ref.watch(currentIndexProvider);
    double newProgress = total > 0 ? (currentIndex + 1) / total : 0;

    // 当索引或进度改变时触发动画
    if (_previousIndex != currentIndex) {
      _previousIndex = currentIndex;
      _imageController.forward(from: 0);
      _textController.forward(from: 0);

      // 为进度条添加动画
      _progressController.animateTo(
        newProgress,
        duration: const Duration(milliseconds: 500),
      );
    }

    if (widget.list.isEmpty) return const SizedBox.shrink();
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      color: theme.scaffoldBackgroundColor,
      child: Container(
        width: 520,
        height: 360,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _imageAnimation,
              child: FadeTransition(
                opacity: _imageAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(widget.list[currentIndex].previews),
                    key: ValueKey(widget.list[currentIndex].id),
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // 省略号动画文字
            EllipsisAnimationText(text: ref.watch(loadingTextProvider)),
            ScaleTransition(
              scale: _textAnimation,
              child: FadeTransition(
                opacity: _textAnimation,
                child: Text(
                  widget.list[currentIndex].title,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontFamily: 'Microsoft YaHei',
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // 添加带动画效果的进度条
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressAnimation.value,
                    minHeight: 8,
                    color: Colors.blue,
                    backgroundColor: Colors.grey[200],
                  );
                },
              ),
            ),
            ScaleTransition(
              scale: _textAnimation,
              child: FadeTransition(
                opacity: _textAnimation,
                child: Text(
                  '${currentIndex + 1} / $total',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
