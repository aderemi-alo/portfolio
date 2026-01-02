import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/constants.dart';
import '../../../responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.secondaryBackground,
      padding:
          context.responsivePadding + const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterLink(
                label: 'GitHub',
                onTap: () => _launchUrl(AppConstants.githubUrl),
              ),
              const SizedBox(width: 32),
              _FooterLink(
                label: 'Medium',
                onTap: () => _launchUrl(AppConstants.mediumUrl),
              ),
              const SizedBox(width: 32),
              _FooterLink(
                label: 'Email',
                onTap: () => _launchUrl(AppConstants.email),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            '© ${DateTime.now().year} ${AppConstants.fullName}. Built with Flutter Web.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.mutedText),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppTheme.secondaryText),
      ),
    );
  }
}
