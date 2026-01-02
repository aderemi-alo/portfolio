import 'package:flutter/material.dart';
import '../../shared/section_container.dart';
import '../home/sections/projects_section.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SectionContainer(
        child: const ProjectsSection(title: 'All Projects'),
      ),
    );
  }
}
