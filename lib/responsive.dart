import 'dart:math' as math;

import 'package:flutter/material.dart';

// ============== Design Dimensions ==============
// iPhone X dimensions - industry standard for mobile-first design
// All proportional scaling is relative to these base dimensions.

/// Base design width (375px - iPhone X)
const double _kDesignWidth = 375.0;

/// Base design height (812px - iPhone X)
const double _kDesignHeight = 812.0;

/// Device breakpoints for responsive design
enum DeviceType {
  /// Phones: < 600px width
  mobile,

  /// Tablets: 600-1199px width
  tablet,

  /// Desktop/Web: >= 1200px width
  desktop,
}

/// Built-in responsive utilities for Klyro
///
/// Zero-dependency responsive system using MediaQuery.
/// Optimized for target devices: Tecno, Infinix, iPhone, iPad, Web.
///
/// Breakpoints:
/// - Mobile: < 600px (default)
/// - Tablet: 600-1199px
/// - Desktop: >= 1200px
extension ResponsiveExtension on BuildContext {
  /// Returns value based on current device width.
  ///
  /// ```dart
  /// final padding = context.responsive<double>(
  ///   mobile: 16,
  ///   tablet: 24,
  ///   desktop: 32,
  /// );
  /// ```
  T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    final width = MediaQuery.sizeOf(this).width;
    if (width >= 1200) return desktop ?? tablet ?? mobile;
    if (width >= 600) return tablet ?? mobile;
    return mobile;
  }

  /// Current device type based on screen width
  DeviceType get deviceType {
    final width = MediaQuery.sizeOf(this).width;
    if (width >= 1200) return DeviceType.desktop;
    if (width >= 600) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  /// True if device is a phone (width < 600px)
  bool get isMobile => deviceType == DeviceType.mobile;

  /// True if device is a tablet (600-1199px)
  bool get isTablet => deviceType == DeviceType.tablet;

  /// True if device is desktop/web (>= 1200px)
  bool get isDesktop => deviceType == DeviceType.desktop;

  /// Screen width in logical pixels
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Screen height in logical pixels
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Responsive horizontal padding
  ///
  /// - Mobile: 16px
  /// - Tablet: 24px
  /// - Desktop: 32px
  EdgeInsets get responsivePadding => EdgeInsets.symmetric(
    horizontal: responsive<double>(mobile: 16, tablet: 24, desktop: 32),
  );

  /// Maximum content width for readability
  ///
  /// Constrains content on large screens to prevent overly long lines.
  /// - Mobile/Tablet: Full width
  /// - Desktop: 800px max
  double get maxContentWidth => responsive<double>(
    mobile: double.infinity,
    tablet: double.infinity,
    desktop: 800,
  );

  // ============== Responsive Typography ==============

  /// Responsive font scale multiplier for display text
  ///
  /// - Mobile: 1.0x (base)
  /// - Tablet: 1.1x (slightly larger for larger screens)
  /// - Desktop: 1.15x
  double get responsiveFontScale =>
      responsive<double>(mobile: 1.0, tablet: 1.1, desktop: 1.15);

  /// Clamped text scale factor to prevent accessibility settings from breaking layout
  ///
  /// Allows 0.85x to 1.3x scaling maximum to maintain layout integrity
  /// while still supporting accessibility needs.
  double get clampedTextScale => MediaQuery.textScalerOf(
    this,
  ).clamp(minScaleFactor: 0.85, maxScaleFactor: 1.3).scale(1.0);

  // ============== Responsive Spacing ==============

  /// Responsive spacing multiplier for proportional scaling
  ///
  /// - Mobile: 1.0x (base)
  /// - Tablet: 1.25x
  /// - Desktop: 1.5x
  double get responsiveSpacingScale =>
      responsive<double>(mobile: 1.0, tablet: 1.25, desktop: 1.5);

  /// Scales a base spacing value responsively
  ///
  /// Usage:
  /// ```dart
  /// SizedBox(height: context.responsiveSpacing(KlyroSpacing.md))
  /// ```
  double responsiveSpacing(double base) => base * responsiveSpacingScale;

  // ============== Proportional Scaling (flutter_screenutil-style) ==============

  /// Width scale factor relative to design width (375px)
  double get _scaleWidth => screenWidth / _kDesignWidth;

  /// Height scale factor relative to design height (812px)
  double get _scaleHeight => screenHeight / _kDesignHeight;

  /// Minimum scale factor (for consistent radius/icon scaling)
  double get _scaleMin => math.min(_scaleWidth, _scaleHeight);

  /// Scales a value proportionally to screen width.
  ///
  /// Use for horizontal dimensions (widths, horizontal padding/margin).
  ///
  /// ```dart
  /// Container(width: context.w(100)) // 100px on 375w design
  /// Padding(padding: EdgeInsets.symmetric(horizontal: context.w(16)))
  /// ```
  double w(num value) => value.toDouble() * _scaleWidth;

  /// Scales a value proportionally to screen height.
  ///
  /// Use for vertical dimensions (heights, vertical padding/margin).
  ///
  /// ```dart
  /// SizedBox(height: context.h(24))
  /// Padding(padding: EdgeInsets.symmetric(vertical: context.h(8)))
  /// ```
  double h(num value) => value.toDouble() * _scaleHeight;

  /// Scales a value using min(width, height) ratio.
  ///
  /// Use for elements that should maintain aspect ratio (radius, icons).
  /// Prevents distortion on extreme aspect ratios.
  ///
  /// ```dart
  /// BorderRadius.circular(context.r(16))
  /// Icon(Icons.home, size: context.r(24))
  /// ```
  double r(num value) => value.toDouble() * _scaleMin;

  /// Scales font size proportionally to screen width.
  ///
  /// Use for text that should scale with screen size.
  ///
  /// ```dart
  /// Text('Hello', style: TextStyle(fontSize: context.sp(14)))
  /// ```
  double sp(num value) => value.toDouble() * _scaleWidth;

  // ============== EdgeInsets Presets ==============

  /// Horizontal symmetric padding (scaled).
  ///
  /// ```dart
  /// Padding(padding: context.paddingH(16))
  /// ```
  EdgeInsets paddingH(num value) => EdgeInsets.symmetric(horizontal: w(value));

  /// Vertical symmetric padding (scaled).
  ///
  /// ```dart
  /// Padding(padding: context.paddingV(12))
  /// ```
  EdgeInsets paddingV(num value) => EdgeInsets.symmetric(vertical: h(value));

  /// All-sides padding (scaled with r for consistency).
  ///
  /// ```dart
  /// Padding(padding: context.paddingAll(16))
  /// ```
  EdgeInsets paddingAll(num value) => EdgeInsets.all(r(value));

  /// Symmetric horizontal AND vertical padding.
  ///
  /// ```dart
  /// Padding(padding: context.paddingSymmetric(h: 16, v: 8))
  /// ```
  EdgeInsets paddingSymmetric({num h = 0, num v = 0}) =>
      EdgeInsets.symmetric(horizontal: w(h), vertical: this.h(v));

  /// LTRB padding (left, top, right, bottom) - all scaled.
  ///
  /// ```dart
  /// Padding(padding: context.paddingLTRB(16, 8, 16, 24))
  /// ```
  EdgeInsets paddingLTRB(num left, num top, num right, num bottom) =>
      EdgeInsets.fromLTRB(w(left), h(top), w(right), h(bottom));

  /// Only-sides padding (scaled).
  ///
  /// ```dart
  /// Padding(padding: context.paddingOnly(left: 16, bottom: 24))
  /// ```
  EdgeInsets paddingOnly({
    num left = 0,
    num top = 0,
    num right = 0,
    num bottom = 0,
  }) => EdgeInsets.only(
    left: w(left),
    top: h(top),
    right: w(right),
    bottom: h(bottom),
  );

  /// Custom scaled border radius.
  ///
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(borderRadius: context.radius(12)),
  /// )
  /// ```
  BorderRadius radius(num value) => BorderRadius.circular(r(value));

  /// Custom scaled border radius for specific corners.
  ///
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(
  ///     borderRadius: context.radiusOnly(topLeft: 16, topRight: 16),
  ///   ),
  /// )
  /// ```
  BorderRadius radiusOnly({
    num topLeft = 0,
    num topRight = 0,
    num bottomLeft = 0,
    num bottomRight = 0,
  }) => BorderRadius.only(
    topLeft: Radius.circular(r(topLeft)),
    topRight: Radius.circular(r(topRight)),
    bottomLeft: Radius.circular(r(bottomLeft)),
    bottomRight: Radius.circular(r(bottomRight)),
  );

  // ============== SizedBox Gap Helpers ==============

  /// Horizontal gap (width spacer).
  ///
  /// ```dart
  /// Row(children: [Icon(...), context.gapW(8), Text(...)])
  /// ```
  SizedBox gapW(num value) => SizedBox(width: w(value));

  /// Vertical gap (height spacer).
  ///
  /// ```dart
  /// Column(children: [Text(...), context.gapH(16), Button(...)])
  /// ```
  SizedBox gapH(num value) => SizedBox(height: h(value));
}

/// Responsive widget builder for layout variations
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a responsive layout builder.
  const ResponsiveBuilder({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  /// Widget to show on mobile (required, fallback for all sizes)
  final Widget mobile;

  /// Widget to show on tablet (optional, falls back to mobile)
  final Widget? tablet;

  /// Widget to show on desktop (optional, falls back to tablet then mobile)
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return context.responsive<Widget>(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
