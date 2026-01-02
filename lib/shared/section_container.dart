import 'package:flutter/material.dart';
import '../responsive.dart';
import '../core/theme.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.color,
    this.padding,
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppTheme.primaryBackground,
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1200),
          padding: padding ?? context.responsivePadding,
          child: child,
        ),
      ),
    );
  }
}
