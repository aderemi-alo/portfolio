import 'package:flutter/material.dart';
import '../../shared/section_container.dart';
import '../../responsive.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/articles_section.dart';
import 'sections/footer_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section is always visible
          const SectionContainer(child: HeroSection()),

          // On Desktop, we show everything in one page
          if (context.isDesktop) ...[
            const SectionContainer(child: ProjectsSection()),
            const SectionContainer(child: ArticlesSection()),
            const FooterSection(),
          ],

          // On Mobile, we only show Hero (maybe simple footer),
          // other sections are on separate pages as per requirements.
          if (context.isMobile || context.isTablet) ...[
            // Maybe a small footer or just end here?
            // Let's add the footer for completeness so they can access social links easily
            const FooterSection(),
          ],
        ],
      ),
    );
  }
}
