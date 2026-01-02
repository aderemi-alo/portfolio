import 'package:flutter/material.dart';
import 'routes.dart';
import 'core/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Remi Portfolio',
      theme: AppTheme.darkTheme, // Default to dark as per design
      themeMode: ThemeMode.dark, // Enforce dark for now
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
