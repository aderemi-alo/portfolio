import 'package:flutter/material.dart';
import '../../shared/section_container.dart';
import '../home/sections/articles_section.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SectionContainer(
        child: const ArticlesSection(title: 'All Articles'),
      ),
    );
  }
}
