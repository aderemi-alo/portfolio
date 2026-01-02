import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/constants.dart';
import '../../../responsive.dart';
import '../../../shared/buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          context.responsivePadding + const EdgeInsets.symmetric(vertical: 48),
      child: ResponsiveBuilder(
        mobile: const _HeroContent(
          textAlign: TextAlign.center,
          align: CrossAxisAlignment.center,
        ),
        desktop: Row(
          children: [
            const Expanded(
              child: _HeroContent(
                textAlign: TextAlign.start,
                align: CrossAxisAlignment.start,
              ),
            ),
            // Optional: Image or Visual on right for Desktop
            // Design system doesn't explicitly mention an image, but mockups usually have one.
            // "Web is still missing articles and contact on the home page though"
            // I'll stick to text-focused design as per "Design Principles: Clarity over expression".
          ],
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.textAlign, required this.align});

  final TextAlign textAlign;
  final CrossAxisAlignment align;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppTheme.primaryAccent.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            'AVAILABLE FOR HIRE',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryAccent,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppConstants.fullName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppTheme.primaryText),
          textAlign: textAlign,
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.role,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            height: 1.1,
            fontSize: context.isMobile ? 42 : 64, // Bigger impact
            color: AppTheme.primaryAccent, // Or a gradient if we had one
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 24),
        Text(
          AppConstants.tagline,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppTheme.secondaryText),
          textAlign: textAlign,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: textAlign == TextAlign.center
              ? WrapAlignment.center
              : WrapAlignment.start,
          children: [
            PrimaryButton(
              text: 'Download Resume',
              icon: const Icon(Icons.download, size: 20),
              onPressed: () => _launchUrl(AppConstants.resumeUrl),
            ),
            SecondaryButton(
              text: 'View Projects',
              icon: const Icon(Icons.arrow_forward, size: 20),
              onPressed: () => context.go('/projects'),
            ),
          ],
        ),
      ],
    );
  }
}
