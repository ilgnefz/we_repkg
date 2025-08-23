import 'package:flutter/material.dart';

class SlidingSegmentedTheme extends ThemeExtension<SlidingSegmentedTheme> {
  final Color backgroundColor;
  final Color foregroundColor;

  const SlidingSegmentedTheme({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  ThemeExtension<SlidingSegmentedTheme> copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return SlidingSegmentedTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  ThemeExtension<SlidingSegmentedTheme> lerp(
    covariant ThemeExtension<SlidingSegmentedTheme>? other,
    double t,
  ) {
    if (other is! SlidingSegmentedTheme) {
      return this;
    }
    return SlidingSegmentedTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
    );
  }
}

class ToastTheme extends ThemeExtension<ToastTheme> {
  final Color backgroundColor;

  const ToastTheme({required this.backgroundColor});

  @override
  ThemeExtension<ToastTheme> copyWith({Color? backgroundColor}) {
    return ToastTheme(backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  @override
  ThemeExtension<ToastTheme> lerp(
    covariant ThemeExtension<ToastTheme>? other,
    double t,
  ) {
    if (other is! ToastTheme) {
      return this;
    }
    return ToastTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}

class SideTheme extends ThemeExtension<SideTheme> {
  final TextStyle largeStyle;
  final TextStyle mediumStyle;

  const SideTheme({required this.largeStyle, required this.mediumStyle});

  @override
  ThemeExtension<SideTheme> copyWith({
    TextStyle? largeStyle,
    TextStyle? mediumStyle,
  }) {
    return SideTheme(
      largeStyle: largeStyle ?? this.largeStyle,
      mediumStyle: mediumStyle ?? this.mediumStyle,
    );
  }

  @override
  ThemeExtension<SideTheme> lerp(
    covariant ThemeExtension<SideTheme>? other,
    double t,
  ) {
    if (other is! SideTheme) {
      return this;
    }
    return SideTheme(
      largeStyle: TextStyle.lerp(largeStyle, other.largeStyle, t)!,
      mediumStyle: TextStyle.lerp(mediumStyle, other.mediumStyle, t)!,
    );
  }
}
