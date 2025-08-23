import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 省略号动画文本组件
class EllipsisAnimationText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration animationDuration;

  const EllipsisAnimationText({
    super.key,
    required this.text,
    this.style,
    this.animationDuration = const Duration(milliseconds: 1200),
  });

  @override
  ConsumerState<EllipsisAnimationText> createState() => _EllipsisAnimationTextState();
}

class _EllipsisAnimationTextState extends ConsumerState<EllipsisAnimationText>
    with TickerProviderStateMixin {
  late AnimationController _ellipsisController;
  late Animation<int> _ellipsisAnimation;

  @override
  void initState() {
    super.initState();
    // 省略号动画控制器
    _ellipsisController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat();

    // 整数动画，范围从0到6，表示省略号的数量
    _ellipsisAnimation = IntTween(
      begin: 0,
      end: 6,
    ).animate(_ellipsisController);
  }

  @override
  void dispose() {
    _ellipsisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ellipsisAnimation,
      builder: (context, child) {
        return Text(
          '${widget.text}${'.' * _ellipsisAnimation.value}',
          style: widget.style ?? Theme.of(context).textTheme.bodyMedium,
        );
      },
    );
  }
}