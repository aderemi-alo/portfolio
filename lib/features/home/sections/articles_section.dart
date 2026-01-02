import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../responsive.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({super.key, this.title = 'Latest Writing'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          context.responsivePadding + const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 32),
          // Simple list of articles
          _ArticleItem(
            title: 'Optimizing Flutter Performance at Scale',
            excerpt:
                'How we reduced app launch time by 40% using lazy loading and shader warmup.',
            date: 'Dec 2025',
            onTap: () {},
          ),
          const Divider(height: 48, color: AppTheme.subtleBorder),
          _ArticleItem(
            title: 'Clean Architecture in Dart: A Practical Guide',
            excerpt:
                'Separating concerns without over-engineering your feature modules.',
            date: 'Nov 2025',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ArticleItem extends StatelessWidget {
  const _ArticleItem({
    required this.title,
    required this.excerpt,
    required this.date,
    required this.onTap,
  });

  final String title;
  final String excerpt;
  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                ),
              ),
              if (context.isDesktop)
                Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppTheme.mutedText),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            excerpt,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.secondaryText),
          ),
        ],
      ),
    );
  }
}
