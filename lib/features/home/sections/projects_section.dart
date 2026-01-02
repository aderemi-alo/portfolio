import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../responsive.dart';
import '../../../shared/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, this.title = 'Featured Projects'});

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
          const SizedBox(height: 16),
          Text(
            "A selection of technical challenges I've solved.",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.secondaryText),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = context.isDesktop;
              // Simple grid logic
              return GridView.count(
                crossAxisCount: isDesktop ? 2 : 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                childAspectRatio: isDesktop
                    ? 1.2
                    : 0.9, // Adjust based on card content
                children: [
                  ProjectCard(
                    title: 'FinTrack Pro',
                    description:
                        'Users struggled to visualize complex spending patterns. Architected local database layer and implemented custom painters for 60fps charts.',
                    tags: const ['Flutter', 'SQLite', 'Bloc'],
                    onTap: () {}, // Navigate to detail
                  ),
                  ProjectCard(
                    title: 'MediConnect Offline',
                    description:
                        'Offline-first sync engine using conflict resolution strategies and AES encryption for local storage.',
                    tags: const ['Flutter', 'Firebase', 'Riverpod'],
                    onTap: () {},
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
